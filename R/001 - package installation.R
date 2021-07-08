### Install the smkfreediv package

# obtain the currently installed version of the package

if (!("smkfreediv" %in% installed.packages() )) {
  installed_version = "NULL"
} else {
  installed_version = as.character(packageVersion("smkfreediv")[1])
  detach("package:smkfreediv")
}


# install the required version, if this is not the one which is installed

if (!(installed_version == version)) {

devtools::install_git(
  "https://gitlab.com/SPECTRUM_Sheffield/r-packages/smkfreediv.git",
  credentials = git2r::cred_user_pass(username = user, getPass::getPass()),
  ref = version,
  build_vignettes = TRUE
)

}
