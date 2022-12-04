start_postgres() {
    sudo docker run \
    --name myPostgresDb \
    -p 5455:5432 \
    -e POSTGRES_USER=neo \
    -e POSTGRES_PASSWORD=1234 \
    -e POSTGRES_DB=postgresDB \
    -d postgres
}

connect_postgres() {
    psql -h localhost -p 5455 -d postgresDB
}

init_django_project ()
{
    PROJECT_NAME="$1"

    mkdir $PROJECT_NAME
    cd $PROJECT_NAME

    python -m venv venv 
    source venv/bin/activate

    pip install --upgrade pip
    pip install django django-stubs

    django-admin startproject config

    mv config temp
    mv temp/* .
    rm -r temp

    git init
    echo "__pycache__\nvenv\n.idea\n.vscode" > .gitignore

    cd ..
    tmux_start $PROJECT_NAME
}

tmux_start () {
    PROJECT_NAME="$1"

    cd $PROJECT_NAME 
    source venv/bin/activate

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
