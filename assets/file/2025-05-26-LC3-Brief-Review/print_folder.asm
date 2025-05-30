;;; ######################################################################
;;; ##                      Purpose and Description                     ##
;;; ######################################################################

;;; ======================= Purpose ===========================
    ;;
    ;; This program serves as a review for:
    ;;      1. lc3 basics(including I/O)
    ;;      2. run-time stack
    ;;      3. recursion (lc3 implementation)
    ;;      4. linked list (lc3 implementation)
    ;;      5. binary tree (lc3 implementation)
    ;;


;;; ===================== Descriptions ====================
    ;;
    ;; 1. This file primarily serves as a direct lc3 translation of a C program
    ;;    that prints a file directory structure.
    ;;
    ;; 2. The content to be printed is pre-stored in specific data structures.
    ;;    The program prints this content to the console in a pre-order
    ;;    traversal with a specified output format (see desired output for details).
    ;;
    ;; 3. To fully cover the previous purposes and simulate how c programs
    ;;    are translated into lower-level assembly language, all user-defined
    ;;    c functions are implemented on run-time stack.
    ;;    Additionally, we've implemented our own "system call" equivilant to "OUT"
    ;;    and "PUTS" (corresponding to c's "printf()" function). We name them
    ;;    "PRINT_A_CHAR" and "PRINT_A_STRING" respectively. These subroutines don't
    ;;    utilize run-time stack, just as typical system calls in real-world machine.
    ;;    Their implementation is the exactly the same as how lc3 machine implements
    ;;    "OUT" and "PUTS" in its System Space(from x0450 to x0462).
    ;;
    ;;4. The provided test case is absolutely not exhaustive. It was primarily
    ;;   generated by Gemini, and I've only revised some grammar mistakes to
    ;;   ensure it works properly for lc3 syntax. Feel free to add any aditional testcases.
    ;;


;;;======================= Data Structure Design ===================================
;;;
    ;; --------------- Structure of Folders (Binary Tree) ---------------
    ;;
    ;;  We consider each folder as a node in a binary tree.
    ;;  The test case structure is below:
    ;;
    ;;                          root
    ;;                   /                 \
    ;;             projects                media
    ;;             /     \             /          \
    ;;       c_project   blog    documents        photos
    ;;       /     \               /     \             \
    ;;  utils   python_project  reports presentations travel
    ;;                                                    \
    ;;                                                   sub_travel
    ;;

    ;; ---------- Files in a Folder ----------
    ;;
    ;; We use a linked list to store all files within a folder,
    ;; where each file is a node of the linked list.
    ;; The test case structure is as follows:
    ;;
    ;; root:            config.sys
    ;; projects:        README.md
    ;; c_project:       main.c -> Makefile
    ;; utils:           helper.c
    ;; python_project:  main.py -> requirements.txt
    ;; blog:            index.md
    ;; media:           (empty)
    ;; documents:       meeting_notes.docx -> todo_list.txt
    ;; reports:         q1_report.pdf -> budget_summary.xlsx
    ;; presentations:   project_kickoff.pptx
    ;; photos:          IMG001.jpg -> IMG002.jpg
    ;; travel:          trip.txt -> map.png
    ;; sun_travel:      packing_list.md
    ;;

    ;; ---------- Data Structure for Folders and Files ----------
    ;;
    ;; Data Structure of Files in a Folder (linked list):
    ;;   [0] next pointer：points to next file node (if missing, NULL)
    ;;   [1] file name (.STRINGZ)
    ;;
    ;; Data Structure of Folder Nodes：
    ;;   [0] left pointer：points to the left child (if missing, NULL)
    ;;   [1] right pointer：points to the right child (if missing, NULL)
    ;;   [2] file pointer：points to the head of the linked list (if missing, NULL)
    ;;   [3] folder name (.STRINGZ)
    ;;


    ;; ---------- C Structs and Function Prototypes ----------
    ;;
    ;; typedef struct f{
    ;;      struct f* nextfile;
    ;;      const char* filename;
    ;; } file_node;
    ;;
    ;;
    ;; typedef struct F{
    ;;      struct F* left;
    ;;      struct F* right;
    ;;      file_node* file;
    ;;      const char* foldername;
    ;; } folder_node;
    ;;
    ;; // For detailed definitions, refers to comments before each subroutine
    ;;
    ;; void print_space(int n);
    ;; void print_file(int num, file_node* file);
    ;; void print_folder(int depth, folder_node* folder);
    ;;


;;; ====================Desired Output====================
    ;;
    ;; root
    ;;     file: config.sys
    ;;     projects
    ;;         file: README.md
    ;;         c_project
    ;;             file: main.c Makefile
    ;;             utils
    ;;                 file: helper.c
    ;;             python_project
    ;;                 file: main.py requirements.txt
    ;;         blog
    ;;             file: index.md
    ;;     media
    ;;         documents
    ;;             file: meeting_notes.docx todo_list.txt
    ;;             reports
    ;;                 file: q1_report.pdf budget_summary.xlsx
    ;;             presentations
    ;;                 file: project_kickoff.pptx
    ;;         photos
    ;;             file: IMG001.jpg IMG002.jpg
    ;;             travel
    ;;                 file: trip.txt map.png
    ;;                 sub_travel
    ;;                     file: packing_list.md
    ;;


;;; ==================== Conventions ====================
    ;;
    ;; These conventions are based on my understanding and memory of
    ;; run-time stack implementations. Please flag any mistakes.
    ;;
    ;; Registers:
    ;; R4: Global variable pointer
    ;; R5: Stack frame pointer (base of local variables)
    ;; R6: Stack top pointer
    ;;
    ;; Stack structure for each function call:
    ;; M[R5 - ?] <- other local variables
    ;; M[R5 + 0] <- base variable/first local variables (if any)
    ;; M[R5 + 1] <- caller's frame pointer
    ;; M[R5 + 2] <- return address
    ;; M[R5 + 3] <- return value (reserved even for void functions)
    ;; M[R5 + ?] <- function arguments
    ;;
    ;; Other Conventions:
    ;; 1. Function arguments and variables should be accessed via
    ;;    R5(frame pointer) and appropriate offsets, instead of R6.
    ;;
    ;; 2. Function arguments should be pushed into the stack from the
    ;;    right to the left before the call, and local variables should
    ;;    be pushed from top to bottom into the stack.
    ;;
    ;; Special Clarification:
    ;; 1. In this program, all C functions conceptually have no local
    ;;    variables in their definitions. However, ommiting local variables
    ;;    in run-time stack will lead to "undefined" behaviors (or at least,
    ;;    I failed to find corresponding descriptons in our textbook).
    ;;    For conventience, I redundantly assigned a local variable for
    ;;    print_space(), print_file(), and print_folder() to hide this issue.
    ;;
    ;; 2. The main function still lacks local variables. I was unsure how
    ;;    to handle with this so I left R5 undefined within main function.
    ;;    However, R5 is correctly defined in all other three functions, and
    ;;    this ommision in main doesn't affect the overall program behaviour.
    ;;


;;; ######################################################################
;;; ##                The lc3 translation of C code                     ##
;;; ######################################################################

;;; --------------------mian_function-------------------------------------
;;; int main() {
;;;     folder_node* root = get_info();     // get_info() is too complex for me to execute with lc3
;;;                                         // We assume that the info has been read and stored in known data structure
;;;     print_folder(0, rootnode);          // See next subroutine for function definition
;;;     return 0;
;;; }
;;;
;;; R0/R1: temporary register.
    .ORIG   x3000

    ;; set stack top pointer(R6) equals to stack bottom
    LD  R6, STACK_BOTTOM
    ;; main functioin has no local variable and thus I ommit setting R5

    ;; push arguments for print_folder();
    AND R0, R0, #0
    LEA  R1, FOLDER_root
    STR R1, R6, #0
    ADD R6, R6, #-1
    STR R0, R6, #0

    ;; call pirnt_folder()
    JSR PRINT_FOLDER

    ;; pop return value(though void) and arguments
    ADD R6, R6, #3
    HALT

STACK_BOTTOM
    .FILL   x4000


;;; ----------------------PRINT_FOLDER------------------------------------
;;; void print_folder(int depth, folder_node* node) {
;;;     // This is only check for floder_node* root, not base case for all recursion step.
;;;     // A NULL node cannot be passed in if that node is not the root.
;;;     if(node == NULL) {
;;;         return;
;;;     }
;;;
;;;     print_space(depth);
;;;     folder_node* current = node;
;;;     printf("%s", current->foldername);
;;;
;;;     // pre_order print the folder
;;;     if(current->file != NULL) {
;;;         printf("\n");
;;;         print_file(depth+1, current->file);
;;;     }
;;;     if(current->left != NULL) {
;;;         printf("\n");
;;;         print_folder(depth+1, current->left);
;;;     }
;;;     if(current->right != NULL) {
;;;         printf("\n");
;;;         print_folder(depth+1, current->right);
;;;     }
;;; }
;;;
;;; R0: temporary register. Caller save is required.
;;;
PRINT_FOLDER
;;; set book-keeping info
    ADD R6, R6, #-2             ; store return address
    STR R7, R6, #0
    ADD R6, R6, #-1             ; store caller's frame pointer
    STR R5, R6, #0
    ADD R6, R6, #-1             ; set R5 as new frame pointer
    ADD R5, R6, #0

;;; begin execution
    ;; if(node == NULL) condition statements
    LDR R0, R5, #5
    BRz PRINT_FOLDER_DONE

    ;; print space and folder name
    LDR R0, R5, #4              ; print_space(depth);
    ADD R6, R6, #-1
    STR R0, R6, #0
    JSR PRINT_SPACE
    ADD R6, R6, #2              ; pop the return value and argument
    LDR R0, R5, #5              ; folder_node* current = node;
    STR R0, R5, #0
    LDR R0, R5, #0              ; printf("%s", current->file);
    LDR R0, R0, #3
    JSR PRINT_A_STRING

PRINT_FOLDER_FILE
;;; print the file for current folder
;;;
;;; if(current->file != NULL) {
;;;     printf("\n");
;;;     print_file(depth+1, current->file);
;;; }
;;;
    LDR R0, R5, #0              ; file ?= NULL
    LDR R0, R0, #2
    BRz PRINT_FOLDER_LEFT
    ;; printf("\n");
    LD  R0, PRINT_FOLDER_NEWLINE
    JSR PRINT_A_CHAR

    ;; print_file(depth+1, current->file);
    LDR R0, R5, #0              ; push current->file into stack
    LDR R0, R0, #2
    ADD R6, R6, #-1
    STR R0, R6, #0
    LDR R0, R5, #4              ; push depth+1 into stack
    ADD R0, R0, #1
    ADD R6, R6, #-1
    STR R0, R6, #0
    JSR PRINT_FILE              ; call print_file()
    ADD R6, R6, #3              ; pop return value and arguments


PRINT_FOLDER_LEFT
;;; print the left child
;;; if(current->left != NULL) {
;;;     printf("\n");
;;;     print_folder(depth+1, current->left);
;;; }
;;;
    LDR R0, R5, #0              ; current->left ?= NULL
    LDR R0, R0, #0
    BRz PRINT_FOLDER_RIGHT
    ;; printf("\n");
    LD  R0, PRINT_FOLDER_NEWLINE
    JSR PRINT_A_CHAR

    ;; print_folder(depth+1, current->left);
    LDR R0, R5, #0              ; push current->left into stack
    LDR R0, R0, #0
    ADD R6, R6, #-1
    STR R0, R6, #0
    LDR R0, R5, #4              ; push depth+1 into stack
    ADD R0, R0, #1
    ADD R6, R6, #-1
    STR R0, R6, #0
    JSR PRINT_FOLDER            ; recursive call
    ADD R6, R6, #3              ; pop return value and arguments

PRINT_FOLDER_RIGHT
;;; rpint the right child
;;; if(current->right != NULL) {
;;;     printf("\n");
;;;     print_folder(depth+1, current->right);
;;; }
;;;
    LDR R0, R5, #0              ; current->right ?= NULL
    LDR R0, R0, #1
    BRz PRINT_FOLDER_DONE
    ;; printf("\n");
    LD  R0, PRINT_FOLDER_NEWLINE
    JSR PRINT_A_CHAR

    ;; print_folder(depth+1, current->right);
    LDR R0, R5, #0              ; push current->right into stack
    LDR R0, R0, #1
    ADD R6, R6, #-1
    STR R0, R6, #0
    LDR R0, R5, #4              ; push depth+1 into stack
    ADD R0, R0, #1
    ADD R6, R6, #-1
    STR R0, R6, #0
    JSR PRINT_FOLDER            ; recursive call
    ADD R6, R6, #3              ; pop return value and arguments

PRINT_FOLDER_DONE
;;; return control to caller
    ADD R6, R6, #1              ; restore caller's frame pointer
    LDR R5, R6, #0
    ADD R6, R6, #1              ; get return address
    LDR R7, R6, #0
    ADD R6, R6, #1              ; point R6 to return value
    RET

PRINT_FOLDER_NEWLINE
    .FILL   #10
PRINT_FOLDER_SAVE_R0
    .FILL   x0000
PRINT_FOLDER_SAVE_R1
    .FILL   x0000
PRINT_FOLDER_SAVE_R2
    .FILL   x0000


;;; ----------------------PRINT_FILE--------------------------------------
;;; void print_file(int num, file_node * file) {
;;;     if(file == NULL) {
;;;         return;
;;;     } else {
;;;         file_node* next = file;
;;;     }
;;;
;;;     print_space(num);
;;;
;;;     printf("file: ");
;;;
;;;     while(next != NULL) {
;;;         print("%s ", next->filename);
;;;         _next = next.nextfile;
;;;     }
;;; }
;;;
;;; R0:  temporary register
PRINT_FILE
;;; set book-keeping info
    ADD R6, R6, #-2
    STR R7, R6, #0              ; store return address
    ADD R6, R6, #-1
    STR R5, R6, #0              ; store caller's frame pointer
    ADD R6, R6, #-1
    ADD R5, R6, #0              ; set R5 as new frame pointer

;;; begin execution
    ;; if(file == NULL) condition statements
    ST  R0, PRINT_FILE_SAVE_R0
    LDR R0, R5, #5
    BRz PRINT_FILE_DONE
    STR R0, R5, #0

    ;; print_space(num);
    LDR R0, R5, #4
    ADD R6, R6, #-1
    STR R0, R6, #0              ; call print_space()
    JSR PRINT_SPACE
    ADD R6, R6, #2              ; pop return value & arguments

    ;; printf("file: ");
    LEA R0, PRINT_FILE_PROMPT
    JSR PRINT_A_STRING

    ;; while loop
PRINT_FILE_LOOP
    LDR R0, R5, #0              ; while condition
    BRz PRINT_FILE_DONE
    LDR R0, R0, #1              ; printf("%s ", next->filename);
    JSR PRINT_A_STRING
    LD  R0, PRINT_FILE_SPACE
    JSR PRINT_A_CHAR
    LDR R0, R5, #0              ; next->nextfile
    LDR R0, R0, #0
    STR R0, R5, #0
    BRnzp   PRINT_FILE_LOOP

PRINT_FILE_DONE
;;; return control to caller
    LD  R0, PRINT_FILE_SAVE_R0
    ADD R6, R6, #1              ; restore caller's frame pointer
    LDR R5, R6, #0
    ADD R6, R6, #1              ; get return address
    LDR R7, R6, #0
    ADD R6, R6, #1              ; point R6 to return value
    RET

PRINT_FILE_SPACE
    .FILL   #32
PRINT_FILE_PROMPT
    .STRINGZ "file: "
PRINT_FILE_NEWLINE
    .FILL   #10
PRINT_FILE_SAVE_R0
    .FILL   x0000


;;; ---------------------PRINT_SPACE------------------------------------
;;; void print_space(int n) {
;;;     int i = 4 * n;
;;;     while(i > 0) {
;;;         printf(" ");
;;;         i--;
;;;     }
;;; }
;;;
;;; R0: temporary register
PRINT_SPACE
;;; set book-keeping info
    ADD R6, R6, #-2             ; store return address
    STR R7, R6, #0
    ADD R6, R6, #-1             ; store caller's frame pointer
    STR R5, R6, #0
    ADD R6, R6, #-1             ; set R5 as new frame pointer
    ADD R5, R6, #0

;;; begin execution of PRINT_SPACE
    ST  R0, PRINT_SPACE_SAVE_R0
    LDR R0, R5, #4              ; int i = 4 * n;
    ADD R0, R0, R0
    ADD R0, R0, R0
    STR R0, R5, #0

    ;; while loop
PRINT_SPACE_LOOP
    LDR R0, R5, #0              ; while condition
    BRz PRINT_SPACE_DONE
    LD  R0, PRINT_SPACE_SPACE   ; printf(" ");
    OUT
    LDR R0, R5, #0              ; i--;
    ADD R0, R0, #-1
    STR R0, R5, #0
    BRnzp   PRINT_SPACE_LOOP

PRINT_SPACE_DONE
;;; return control to caller
    LD  R0, PRINT_SPACE_SAVE_R0
    ADD R6, R6, #1              ; restore caller's frame pointer
    LDR R5, R6, #0
    ADD R6, R6, #1              ; get return value
    LDR R7, R6, #0
    ADD R6, R6, #1              ; point R6 to return value
    RET

PRINT_SPACE_SPACE
    .FILL   #32
PRINT_SPACE_SAVE_R0
    .FILL   x0000





;;; ######################################################################
;;; ##             PRINT_A_CHAR  &  PRINT_A_STRING                      ##
;;; ######################################################################
;;; This part is almost the same as the true lc3 system call.
;;;
;;; -------------------------PRINT_A_CHAR---------------------------------
;;; The same as "OUT". See lc3 memory form x0450 to x0455 for details.
PRINT_A_CHAR
    ST  R1, PRINT_A_CHAR_SAVE_R1
POLLING
    LDI R1, DSR
    BRzp    POLLING

    STI     R0, DDR

    LD  R1, PRINT_A_CHAR_SAVE_R1
    RET

PRINT_A_CHAR_SAVE_R1
    .FILL   x0000
DSR
    .FILL   xFE04
DDR
    .FILL   xFE06

;;; -------------------------PRINT_A_STRING-------------------------------
;;; The same as "PUTS". See lc3 memory from x0456 to x0462 for details.
PRINT_A_STRING
    ST  R0, PRINT_A_STRING_SAVE_R0
    ST  R1, PRINT_A_STRING_SAVE_R1
    ST  R7, PRINT_A_STRING_SAVE_R7
    ADD R1, R0, #0

PRINT_A_STRING_LOOP
    LDR R0, R1, #0
    BRz PRINT_A_STRING_DONE
    JSR PRINT_A_CHAR
    ADD R1, R1, #1
    BRnzp   PRINT_A_STRING_LOOP

PRINT_A_STRING_DONE
    LD  R0, PRINT_A_STRING_SAVE_R0
    LD  R1, PRINT_A_STRING_SAVE_R1
    LD  R7, PRINT_A_STRING_SAVE_R7
    RET

PRINT_A_STRING_SAVE_R0
    .FILL   x0000
PRINT_A_STRING_SAVE_R1
    .FILL   x0000
PRINT_A_STRING_SAVE_R7
    .FILL   x0000





;;; ######################################################################
;;; ##                             DATA                                 ##
;;; ######################################################################
;;;
;;;
;;; -------------------------folder_info-----------------------------------
FOLDER_root
    .FILL FOLDER_projects       ; left
    .FILL FOLDER_media          ; right
    .FILL FILE_root             ; file
    .FILL FOLDER_NAME_root      ; foldername
FOLDER_NAME_root
    .STRINGZ "root"

FOLDER_projects
    .FILL FOLDER_c_project
    .FILL FOLDER_blog
    .FILL FILE_projects
    .FILL FOLDER_NAME_projects
FOLDER_NAME_projects
    .STRINGZ "projects"

FOLDER_c_project
    .FILL FOLDER_utils
    .FILL FOLDER_python_project
    .FILL FILE_c_project
    .FILL FOLDER_NAME_c_project
FOLDER_NAME_c_project
    .STRINGZ "c_project"

FOLDER_utils
    .FILL x0000
    .FILL x0000
    .FILL FILE_utils
    .FILL FOLDER_NAME_utils
FOLDER_NAME_utils
    .STRINGZ "utils"

FOLDER_blog
    .FILL x0000
    .FILL x0000
    .FILL FILE_blog
    .FILL FOLDER_NAME_blog
FOLDER_NAME_blog
    .STRINGZ "blog"

FOLDER_media
    .FILL FOLDER_documents
    .FILL FOLDER_photos
    .FILL x0000
    .FILL FOLDER_NAME_media
FOLDER_NAME_media
    .STRINGZ "media"

FOLDER_photos
    .FILL x0000
    .FILL FOLDER_travel
    .FILL FILE_photos
    .FILL FOLDER_NAME_photos
FOLDER_NAME_photos
    .STRINGZ "photos"

FOLDER_travel
    .FILL x0000
    .FILL FOLDER_sub_travel
    .FILL FILE_travel
    .FILL FOLDER_NAME_travel
FOLDER_NAME_travel
    .STRINGZ "travel"

FOLDER_python_project
    .FILL x0000
    .FILL x0000
    .FILL FILE_python_project
    .FILL FOLDER_NAME_python_project
FOLDER_NAME_python_project
    .STRINGZ "python_project"

FOLDER_documents
    .FILL FOLDER_reports
    .FILL FOLDER_presentations
    .FILL FILE_documents
    .FILL FOLDER_NAME_documents
FOLDER_NAME_documents
    .STRINGZ "documents"

FOLDER_reports
    .FILL x0000
    .FILL x0000
    .FILL FILE_reports
    .FILL FOLDER_NAME_reports
FOLDER_NAME_reports
    .STRINGZ "reports"

FOLDER_presentations
    .FILL x0000
    .FILL x0000
    .FILL FILE_presentations
    .FILL FOLDER_NAME_presentations
FOLDER_NAME_presentations
    .STRINGZ "presentations"

FOLDER_sub_travel
    .FILL x0000
    .FILL x0000
    .FILL FILE_sub_travel
    .FILL FOLDER_NAME_sub_travel
FOLDER_NAME_sub_travel
    .STRINGZ "sub_travel"


;;; ------------------------file_info-------------------------------------
FILE_root
    .FILL x0000                 ; nextfile
    .FILL FILE_NAME_root        ; filename
FILE_NAME_root
    .STRINGZ "config.sys"

FILE_projects
    .FILL x0000
    .FILL FILE_NAME_projects
FILE_NAME_projects
    .STRINGZ "README.md"

FILE_c_project
    .FILL FILE_c_project_2
    .FILL FILE_NAME_c_project1
FILE_NAME_c_project1
    .STRINGZ "main.c"

FILE_c_project_2
    .FILL x0000
    .FILL FILE_NAME_c_project2
FILE_NAME_c_project2
    .STRINGZ "Makefile"

FILE_utils
    .FILL x0000
    .FILL FILE_NAME_utils
FILE_NAME_utils
    .STRINGZ "helper.c"

FILE_blog
    .FILL x0000
    .FILL FILE_NAME_blog
FILE_NAME_blog
    .STRINGZ "index.md"

FILE_photos
    .FILL FILE_photos_2
    .FILL FILE_NAME_photos1
FILE_NAME_photos1
    .STRINGZ "IMG001.jpg"

FILE_photos_2
    .FILL x0000
    .FILL FILE_NAME_photos2
FILE_NAME_photos2
    .STRINGZ "IMG002.jpg"

FILE_travel
    .FILL FILE_travel_2
    .FILL FILE_NAME_travel1
FILE_NAME_travel1
    .STRINGZ "trip.txt"

FILE_travel_2
    .FILL x0000
    .FILL FILE_NAME_travel2
FILE_NAME_travel2
    .STRINGZ "map.png"

FILE_python_project
    .FILL FILE_python_project_2
    .FILL FILE_NAME_python_project1
FILE_NAME_python_project1
    .STRINGZ "main.py"

FILE_python_project_2
    .FILL x0000
    .FILL FILE_NAME_python_project2
FILE_NAME_python_project2
    .STRINGZ "requirements.txt"

FILE_documents
    .FILL FILE_documents_2
    .FILL FILE_NAME_documents1
FILE_NAME_documents1
    .STRINGZ "meeting_notes.docx"

FILE_documents_2
    .FILL x0000
    .FILL FILE_NAME_documents_2
FILE_NAME_documents_2
    .STRINGZ "todo_list.txt"

FILE_reports
    .FILL FILE_reports_2
    .FILL FILE_NAME_reports1
FILE_NAME_reports1
    .STRINGZ "q1_report.pdf"

FILE_reports_2
    .FILL x0000
    .FILL FILE_NAME_reports2
FILE_NAME_reports2
    .STRINGZ "budget_summary.xlsx"

FILE_presentations
    .FILL x0000
    .FILL FILE_NAME_presentations1
FILE_NAME_presentations1
    .STRINGZ "project_kickoff.pptx"

FILE_sub_travel
    .FILL x0000
    .FILL FILE_NAME_sub_travel
FILE_NAME_sub_travel
    .STRINGZ "packing_list.md"

    .END
