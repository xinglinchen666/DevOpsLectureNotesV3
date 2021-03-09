1. Install virtualenv https://virtualenv.pypa.io/en/latest/installation.html
2. In a folder where you use to create new projects, create a new virtual environment 
`virtualenv -p python3.7 python3.7`
The first "python3.7" refer to the version of python you wish to install, the second "python3.7" refer to the virtual environment folder you wish to name.
After running this command, you will have a new folder "python3.7" created.
3. Activate your new virtual environment
`source python3.7/bin/activate`
4. Verify you are using your virtualenv python
`which python`
This command should prints out your python executable path at [your_virtualenv_path]/python3.7/bin/python
5. Add this activate command to your shell init script. 
	1. if you are using shell, add it to ~/.bashrc and ~/.bash_profile
	2. if you are using zsh, add it to ~/.zshrc
	3. make sure you use the full path for your virtualenv. e.g. if you created virtual environment under /Users/abc/Code, then you should add `source /User/abc/Code/python3.7/bin/activate` to above files
