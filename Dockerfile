FROM python:alpine3.16

WORKDIR /opt/app

COPY main.py app.py

#use parameters --trusted-host if you are behind any firewall that may cause error during pip install
RUN pip install flask

EXPOSE 4441

CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0", "--port=4441"]
