init_django_project ()
{
    PROJECT_NAME="$1"

    python -m venv venv 

    pip install --upgrade pip
    pip install django django-stubs

    django-admin startproject config

    mv config $PROJECT_NAME
    mv venv $PROJECT_NAME 

    git init $PROJECT_NAME
    echo "__pycache__\nvenv\n.idea\n.vscode" > .gitignore

    tmux_start $PROJECT_NAME
}

tmux_start () {
    PROJECT_NAME="$1"

    cd $PROJECT_NAME 
    . venv/bin/activate

    tmux new -s $PROJECT_NAME -d

    tmux new-window -t $PROJECT_NAME:2
    tmux rename-window -t $PROJECT_NAME:2 server
    tmux send-keys -t $PROJECT_NAME:2 './manage.py runserver' Enter

    tmux new-window -t $PROJECT_NAME:3
    tmux rename-window -t $PROJECT_NAME:3 tests

    tmux rename-window -t $PROJECT_NAME:1 code
    tmux send-keys -t $PROJECT_NAME:1 'nvim .' Enter

    tmux attach -t $PROJECT_NAME
}
