#!/usr/bin/env python

import os
import sys
import shutil
from time import strftime

def link(src, dest):
    src = os.path.abspath(src)
    dest = os.path.expanduser(dest)
    if not os.path.exists(src):
        raise Exception('%s doesnt exist' % src)

    if not os.path.exists(os.path.dirname(dest)):
        os.makedirs(os.path.dirname(dest))

    if os.path.exists(dest):
        if os.path.islink(dest):
            if os.path.abspath(os.readlink(dest)) == src:
                print 'Link already in place: %s' % src
                return
        
        backup = dest + '.backup.' + strftime("%Y.%m.%d")
        print 'Backing up current copy to %s' % backup
        if os.path.exists(backup): raise Exception('Backup already exists')
        os.rename(dest, backup)
    
    print 'Softlinking %s to %s' % (src, dest)
    os.symlink(src, dest)


def main():
    print "Linking each config file in its correct place"
    print '=-'*30
    
    # link the base .bashrc that the system specfic ones source
    link('_bashrc.base', '~/.bashrc.base')
    
    # link the correct system-specfic bashrc to ~/.bashrc
    try:
        hostname_root = os.uname()[1].split('.')[0]
        link('_bashrc.' + hostname_root, '~/.bashrc')
    except Exception as e:
        print 'Using default bashrc'
        link('_bashrc.default', '~/.bashrc')

    # link _bash_profile to .bash_profile
    link('_bash_profile', '~/.bash_profile')

    # link .emacs to _emacs
    link('_emacs', '~/.emacs')
    link('_emacs.d', '~/.emacs.d')
    
    # link git config
    link('_gitconfig', '~/.gitconfig')

    # link ipython_config.py
    if os.path.exists(os.path.expanduser('~/.ipython/profile_default')):
        link('ipython_config.py', '~/.ipython/profile_default/ipython_config.py')
    elif os.path.exists(os.path.expanduser('~/.config/ipython/profile_default')):
        link('ipython_config.py', '~/.config/ipython/profile_default/ipython_config.py')
    else:
        print 'Could not find an ipython config directory'
        
    # link ipython_config_profile_msm.py
    if os.path.exists(os.path.expanduser('~/.ipython/profile_msm')):
        link('ipython_config_profile_msm.py', '~/.ipython/profile_msm/ipython_config.py')
    elif os.path.exists(os.path.expanduser('~/.config/ipython/profile_msm')):
        link('ipython_config_profile_msm.py', '~/.config/ipython/profile_msm/ipython_config.py')
    else:
        print 'Could not find an ipython config directory for profile=msm'
        
    # link ipython_config_profile_msm.py
    if os.path.exists(os.path.expanduser('~/.ipython/profile_units')):
        link('ipython_config_profile_units.py', '~/.ipython/profile_units/ipython_config.py')
    elif os.path.exists(os.path.expanduser('~/.config/ipython/profile_units')):
        link('ipython_config_profile_units.py', '~/.config/ipython/profile_units/ipython_config.py')
    else:
        print 'Could not find an ipython config directory for profile=units'

    # link matplotlibrc
    if sys.platform.startswith('linux'):
        if 'XDG_CONFIG_HOME' in os.environ:
            link('matplotlibrc', '%s/matplotlib/matplotlibrc' % os.environ['XDG_CONFIG_HOME'])
        else:
            link('matplotlibrc', '~/.config/matplotlib/matplotlibrc')
    else:
        link('matplotlibrc', '~/.matplotlib/matplotlibrc')

    if 'TEXINPUTS' in os.environ:
        link('rmcgibbo-latex.sty', '~/.LaTeX/rmcgibbo-latex.sty')
    else:
        print 'Skipping installing custom LaTeX style file because'
        print "I didn't find the 'TEXINPUT' environment variable"
        print "(It should point to ~/.LaTeX for this to work)"
        print "After creating ~/.LaTeX, you will probably need to run"
        print "the command 'texhash' to rebuild the LaTeX hash to find"
        print "the new packages."

if __name__ == '__main__':
    main()
