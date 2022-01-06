# Run as root until custom image is made
install.packages('distill')

# Initialise the distill website 
library('distill')
create_website(dir = "gh-pages", title = "My reproducible research project")
# Builds the website in the directory `gh-pages`. Change Github pages to render from this folder.
