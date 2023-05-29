r"""Configure the Sphinx documentation builder.

https://www.sphinx-doc.org/en/master/usage/configuration.html
"""
import os
import subprocess  # nosec: B404

if os.environ.get("READTHEDOCS") == "True":
    subprocess.call(  # nosec: B602 B607
        "cd ..; cmake -Bbuild -DZH_TW=ON -DHTML=ON", shell=True
    )

version = "rolling"
author = "wzy"
copyright = "2023"
project = "tmux"

# -- Path setup --------------------------------------------------------------

# If extensions (or modules to document with autodoc) are in another directory,
# add these directories to sys.path here. If the directory is relative to the
# documentation root, use os.path.abspath to make it absolute, like shown here.

# -- Project information -----------------------------------------------------
language = "zh_CN"
locale_dirs = ["locale"]
gettext_compact = False

# -- General configuration ---------------------------------------------------

# Add any Sphinx extension module names here, as strings. They can be
# extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
# ones.
extensions = [
    "myst_parser",
]

myst_heading_anchors = 3
myst_title_to_header = True

# Add any paths that contain templates here, relative to this directory.
templates_path = ["_templates"]

# List of patterns, relative to source directory, that match files and
# directories to ignore when looking for source files.
# This pattern also affects html_static_path and html_extra_path.
exclude_patterns = ["_build", "Thumbs.db", ".DS_Store"]


# -- Options for HTML output -------------------------------------------------

# The theme to use for HTML and HTML Help pages.  See the documentation for
# a list of builtin themes.
#

# Add any paths that contain custom static files (such as style sheets) here,
# relative to this directory. They are copied after the builtin static files,
# so a file named "default.css" will overwrite the builtin "default.css".
# html_static_path = ["_static"]
READTHEDOCS_LANGUAGE = os.environ.get("READTHEDOCS_LANGUAGE", language)
html_extra_path = [f"../build/{READTHEDOCS_LANGUAGE}"]
