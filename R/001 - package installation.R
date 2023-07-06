### Install the smkfreediv package

# install the required version

devtools::install_git(
  "https://gitlab.com/SPECTRUM_Sheffield/r-packages/smkfreediv.git",
  credentials = git2r::cred_user_pass(username = user, getPass::getPass()),
  ref = version,
  build_vignettes = FALSE
)


