# Pages whose permalink is an external URL (e.g. _pages/cv.md) only exist to add a
# link to the navbar. Drop them after rendering so Jekyll doesn't write junk files.
Jekyll::Hooks.register :site, :post_render do |site|
  site.pages.reject! { |page| page.data["permalink"].to_s.include?("://") }
end
