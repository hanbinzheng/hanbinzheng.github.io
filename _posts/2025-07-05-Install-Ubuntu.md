---
title: "Install Ubuntu"
date: 2025-07-05 +0800
categories: [RM]
tags: [System, RM]
---

> 这个是我在原有Ubuntu24.04上安装Ubuntu24.04+Ubuntu22.04双系统经历。其中`2. 准备启动盘`这一部分部分跟原先系统有关（Ubuntu），其余部分也适用于Windows

---

## 1. 一些基本的系统知识

下面是一些我认为有用的基本知识。如果你不知道这些知识也没有关系，因为我也不知道。我也是现学的。感谢Gemini，这些`基本的系统知识`由Gemini生成。如果你没有看懂，没有关系，因为我也没有完全看懂。你只需要大改知道每一个东西是做什么的就可以了。

- **BIOS (Basic Input/Output System) / UEFI (Unified Extensible Firmware Interface)** 它们是电脑开机时最先运行的程序，相当于电脑的“管家”。它们负责检测硬件、启动操作系统。UEFI 是 BIOS 的升级版，功能更强大，安全性更好，现在大部分新电脑都用的是 UEFI。

  - **Secure Boot (安全启动)**：这是 UEFI 的一个功能，旨在防止恶意软件在系统启动前加载。为了安装双系统，我们通常建议**关闭**它。
  - **Boot Mode / CSM (Compatibility Support Module)**：这个选项决定了电脑是使用 UEFI 模式启动还是兼容传统的 BIOS 模式启动。为了安装 Ubuntu，通常建议使用 **UEFI 模式**。如果你在启动盘制作和设置中遇到问题，可能需要尝试启用 CSM 或切换到 Legacy BIOS 模式，但这一般不是首选。
  - **Fast Boot (快速启动)**：这个功能可以加快电脑的启动速度，但有时会影响双系统或启动盘的识别。为了确保顺利安装，建议**关闭**它。

- **Boot Menu (启动菜单)** 这是一个在电脑启动时按特定按键（通常是 F2, F10, F12, Del 等，不同品牌电脑不同）可以进入的菜单。通过它，你可以选择从哪个设备启动，比如从内部硬盘（原有的系统）或者我的 Ubuntu22.04 启动盘启动。

  

- **Live 环境 (Live System / Live USB)** 当我用制作好的 Ubuntu22.04 启动盘启动电脑时，它不会直接安装系统，而是进入一个临时的、功能完整的 Ubuntu 系统。这个临时的系统就叫做 **Live 环境**。你可以在 Live 环境中体验 Ubuntu、上网、备份文件，更重要的是，进行**分区**和**安装操作系统**。在 Live 环境下进行的操作，不会影响电脑硬盘上已有的数据，除非你开始安装系统并选择修改硬盘。

  

- **分区 (Partition)** 分区就像是把一个大硬盘分成几个独立的小区域。每个区域可以用来安装不同的操作系统，或者存储不同类型的数据。比如，我可以创建一个区域给 Ubuntu 24.04，另一个区域给 Ubuntu 22.04，再创建一个区域来存储我的个人文件。

  

- **引导器 (Bootloader)** 当你有多个操作系统时（比如我想安装 Ubuntu 24.04 和 Ubuntu 22.04 双系统），就需要一个程序来帮我选择启动哪个系统。这个程序就是**引导器**。Ubuntu 默认的引导器是 **GRUB (Grand Unified Bootloader)**。它会在电脑开机时出现一个菜单，让我们选择是进入 Ubuntu 24.04 还是 Ubuntu 22.04。

  

- **EFI 系统分区 (EFI System Partition / ESP) / 公共分区** 在 UEFI 模式下安装系统时，需要一个专门的**EFI 系统分区**。这个分区通常比较小，用于存放引导器（比如 GRUB）和启动操作系统所需的文件。它相当于 UEFI 模式下系统的“启动大脑”。两个 Ubuntu 系统可以共用一个 EFI 分区，这也是我们推荐的做法。



---

## 2. 准备启动盘(如果你有现成的启动盘，直接跳过这一步)

一个普通的U盘只是装文件的。但是一个启动盘可以让电脑从这个启动盘里启动。你不可以直接复制文件到U盘里然后试图装系统。你需要把ubuntu的镜像写到U盘的底层扇区里。

1. 进入[官网](https://releases.ubuntu.com/22.04/)https://releases.ubuntu.com/22.04/，找到Desktop Image(不是Server Install Image)，下载Ubuntu22.04镜像(名字叫ubuntu-22.04.5-desktop-amd64.iso，大小约4.4GB)

   

2. 清理U盘。

   * 插入U盘，在终端输入指令:

     ```terminal
     lsblk
     ```

     然后在输出中，找到类似下面的:

     ```terminal
     NAME   MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
     sda      8:0    1   32G  0  disk       										# ← 这就是你的 U 盘
     └─sda1   8:1    1   32G  0  part /media/zhb/UBUNTU 24_0		# zhb是你的用户名，UBUNTU 24_0是某文件夹
     ```

     找到那个大小为32G(这里是指你U盘实际的大小)的sda(sdb, sdc, ...不要看错，一定要找对)

   * U盘是默认挂载在某个文件夹下，你需要手动卸载它才可以写入。

     下面是一些关于linux组织文件的简单介绍。如果不感兴趣，可以直接执行本小点最后列出的指令。

     在linux里，所有东西都被组织成一棵**统一的目录树**，以 / 为根：

     ```terminal
     /
     ├── bin/           # 系统基本命令（如 ls, cp, mv）
     ├── boot/          # 启动加载器用的文件（如 vmlinuz, grub）
     ├── dev/           # 所有设备文件（磁盘、U盘、终端等）
     │   └── sda        # 你的U盘本体（block device）
     │   └── sda1       # U盘上的第一个分区
     ├── etc/           # 所有系统配置文件
     ├── home/
     │   └── zhb/       # 你自己的用户目录（~）
     ├── media/
     │   └── zhb/
     │       └── UBUNTU 24_0   # U盘插入后自动挂载的位置
     ├── tmp/           # 临时文件夹（开机自动清空）
     ├── usr/           # 用户软件、头文件、文档（不是你的 home）
     ├── var/           # 日志、缓存、数据库、邮件等变化的文件
     ```

     我插入的 U 盘是` /dev/sda` (`/dev/sda1`是U盘内部的分区)，被系统自动挂载到了 `/media/zhb/UBUNTU 24_0`

     如果现在想对整个 U 盘` /dev/sda `写入镜像，**必须先“卸载”这个挂载点**，否则系统会拒绝写入。

     挂载的路径是:

     ```terminal
     /media/zhb/UBUNTU 24_0
     ```

     对应的设备是:

     ```terminal
     /dev/sda1
     ```

     你需要执行以下指令来卸载U盘：

     ```terminal
     sudo umount /dev/sda1				# 将其中的 /dev/sda1 替换为你刚才找到的那个 U 盘设备名
     ```

     在卸载完之后，重新执行`lsblk`, 确认`/media/zhb/UBUNTU 24_0`的` MOUNTPOINT`这一栏的输出为空(没有` /media/...`)，那么说明卸载成功。因为`lsblk`会列出所有分区信息，不管是否挂载，所以`/media/zhb/UBUNTU 24_0`不会消失。除了这个办法，你也可以通过`mount | grep sda`指令来检测。如果这个执行这个指令后没有输出，说明卸载成功。如果有输出，说明卸载失败。

     

3. 将iso镜像烧录到U盘里

   如果有兴趣，可以进行分区清空与 gparted 格式化。但是我没有兴趣，所以我直接烧录了。

   我们假设你下载好的iso镜像的路径为`/Downloads/ubuntu-22.04.5-desktop-amd64.iso`，假设你的输出设备(U盘)为`/dev/sda` (不是 sda1)，执行下面的指令(注意把对应路径替换成你的实际路径):

   ```terminal
   sudo dd if=~/Downloads/ubuntu-22.04.5-desktop-amd64.iso of=/dev/sda bs=4M status=progress conv=fdatasync
   ```

   | 参数            | 含义                                      |
   | --------------- | ----------------------------------------- |
   | if=...          | ISO                                       |
   | of=...          | 输出设备：你的 U 盘 /dev/sda（不是 sda1） |
   | bs=4M           | 每次写入 4MB，提升速度                    |
   | status=progress | 显示进度                                  |
   | conv=fdatasync  | 写完强制刷盘，防止假成功                  |

   执行时间可能 要一小会儿，视你 U 盘写入速度决定，过程中终端不会响应输入，耐心等。完成之后会显示类似下面的输出：

   ```terminal
   123456789 bytes (123 MB, ...) copied, 60.1 s, ...
   ```

   然后你再执行:

   ```terminal
   sync
   ```

   确保缓冲区完全落盘。

   

## 3. 安装双系统

1. 进入Ubuntu22.04的Live界面。

   插入做好的启动盘，重启电脑。然后在电脑启动的时候狂按`ESC`或者`F8`(这个是Boot Menu键，视电脑品牌而定。我的电脑是F8无效，ESC可以)。然后在`Boot Menu`中选择你的USB设备，名字类似于`UEFI: USB, Partition2(USB)`。随后，选择`Try or Install Ubuntu`。他会用你的启动盘来启动电脑。在电脑启动完后，在桌面跳出来的图标上选择`Try Ubuntu`(千万不要在这个时候直接`Install Ubuntu`，那会抹掉你原来的操作系统)，其他保持默认。这个时候，我们进入了 Live Ubuntu 临时桌面。再强调一遍，进入后，**不要点击**`Install Ubuntu`！！！

   

2. 给即将装载的Ubuntu22.04分区。

   * 点击左下角的搜索 (九宫格图标) 或者按`Super`键 (如果你用windows的话，大概率是有windows图标的那个)，搜索`GParted`然后进入这个软件。你会看到如下的内容

     ```terminal
     Partition          File System      Size        Used/Unsued/flags......
     /dev/nvme0n1p1        fat32        1.05GiB      .....
     /dev/nvme0n1p2        ext4         952.8GiB     39.69GiB Used, 913.13GiB Unused
     unallocated        unallocated     1.34 MB      ...
     ```

     找到那个最大的，`ext4`的那个。这个是我们现在系统所占的区域。我们需要在这块区域里挤出一块新区域给新的操作系统(学长说64GB就够了，我是分了100GB)。下一步我们进行分区操作。

   *  在`GParted`软件中，鼠标左键选中`/dev/nvme0n1p2 ext4`这一项，随后右键，选中`Resize/Move`。这个时候你会看到一个条形图和一些可以改变数字的选项。这个就是我们进行分区的地方。注意，**不要动`Free Space Preceeding(Mib)`**这一项，保持默认。然后你可以拖动条形图，或者手动填写`free space following`来调整分区的大小。点击`Resize/Move`回到主页面。这个时候，你会看到`/dev/nvme0n1p2`缩小了，并且多了一块`unallocated`(这个是你刚刚设定的)。随后点击上方工具栏里的`Apply ALL Operations`(绿色勾✅的那个)，这个是分区的最后一步，可能需要一小会儿。

     

3.  安装Ubuntu22.04到新分区。

   * 回到桌面，点击Ubuntu安装器的图标，进入安装器 (名字叫`Install Ubuntu 22.04.5 LTS`，图标位于右下角`Home`文件夹的上方，或者最左上角)。这个可能点了不一定有用，要等一小会儿，如果没出来不要害怕。他会询问你一些默认设置，比如语言，键盘布局，要不要联网什么的，在碰到`Installation type`之前可以随意选择。但是个人建议选上`Install third-party software for graphics and WiFi hardware and additional media format`。在你进行操作的时候，他可能会跳出来说

     ```
     Unmount partitions that are in use?
     The installer has detected that the following disks have mounted partitions:/dev/nvme0n1
     Do you want the installer to try to unmount the partitions on these disks before continuing? If you leave them mounted, you will not be able to create, delete, or resize partitions on these disks, but you may be able to install to existing partitions there.
     																																						Yes / No
     ```

     这个是因为，你现在正在运行安装器的时候，在Live模式里有些东西自动挂载了。你**需要选择YES**来允许安装器自动卸载正在挂载的分区。 

     

   * 当你碰到了`Installation type`，请选择`sth else`而不是`Erase disk and install Ubuntu`。如果你不想毁掉你原来的东西，就不要选带`Erase`的那个。然后continue，进入手动分区界面。

     在这个界面，找到你刚刚分出来的`free space`，选中这一行，然后点击左下角的`+`按钮。在出现的对话框里，进行如下设置：


     | Size | Type for the new partition | Location for the new partition | Use as | Mount point |
     | ---- | -------------------------- | ------------------------------ | ------ | ----------- |
     | 默认 | Primary                    | Beginning of this space        | Ext4   | /           |


     完成设置后，检查是否存在类似于`/dev/nvme0n1p1 `的内容。它如果被正常识别为`efi`或`esp`，就不需要改动。

     接下来是最重要的一步：指定引导器安装位置。你需要确保你界面底部有这样的标识：

     ```
     Device for bootloader installation:
     /dev/nvme0n1		........
     ```

     你必须选择 **`/dev/nvme0n1`（整个硬盘）**，**而不是 `/dev/nvme0n1p1`、或者p2,  p3**

     

   *  确认无误后，点击 `Install Now` 开始正式安装。在安装过程中，他会问你一堆问题，你正常填就好。这个安装要一会儿。

     

4.  处理好引导器。

   做完后，他会让你重启。你需要按照他的要求重启，然后在屏幕出现`移除安装介质`的时候拔掉U盘然后按照他说的按`Enter`。接下来不要动它。如果你之前选了`Install third-party software for graphics and WiFi hardware and additional media format`在一段时间后，他会出现

   ```
   Perform MOK Management
   
   Continue boot
   Enroll Mok
   Enroll key from disk
   Enroll hash from disk
   ```

   来给你选。这个是**MOK（Machine Owner Key）管理界面**，这是 Ubuntu 安装了**安全引导（Secure Boot）签名的第三方驱动**（比如 Wi-Fi、NVIDIA）时，系统 UEFI 要求你做出的信任授权，否则系统会拒绝加载那些驱动。你需要选`Enroll MOK`。

   

   如果你接下来的开机里出现了

   ```
   Ubuntu 22.04
   Ubuntu 24.04 (我是Ubuntu 24.04，你可能是Windows)
   Advanced options for Ubuntu ...
   ```

   那么很好，引导器起作用了。

   

   但是我装的时候没有。下面的内容是针对如何在Ubuntu24.02里**显式唤出 GRUB 菜单 + 检查它是否识别到 Ubuntu24.04**. 如果你的引导器起作用了，可以跳过

   * 在搜索框里找到终端`Terminal`，输入指令`sudo update-grub`。

     如果输出里有类似

     ```terminal
     Generating grub configuration file ...
     Found linux image: /boot/vmlinuz-...
     Found Ubuntu 22.04.5 LTS on /dev/nvme0n1p3
     Found Ubuntu 24.04.2 LTS on /dev/nvme0n1p2
     ...
     ```

     的内容，那么说明找到了Ubuntu24.04

   * 编辑配置文件(我用的是vim，如果你从未用过vim，nano简单一点，把下面指令的vim改成nano)，
     ```terminal
     sudo vim /etc/default/grub
     ```

      然后把这里面改成下面的格式：
     
     ```terminal
     GRUB_TIMEOUT=5
     GRUB_TIMEOUT_STYLE=menu
     ```

   * 然后重新生成GRUB

     ```terminal
     sudo update-grub
     ```

     再执行

     ```terminal
     sudo reboot
     ```

     现在执行重启完，你现在会在桌面看到**GRUB 菜单**，可以选择对应的系统了。 

