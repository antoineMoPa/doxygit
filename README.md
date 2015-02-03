doxygit
=======
A doxygen based tool to create the documentation of your project from its git repository.

Setting Up
==========

Install node-js and ruby and doxygen

Install dependencies

    cd backend
    npm install

Make static files available by creating a symlink to the www doxygit folder in your public html folder

    # change that to the appropriate directories
    cd /var/www
    sudo ln -s /home/you/your-code-folder/doxygit/www doxygitStatic

Run server

    cd backend
    node index.js
