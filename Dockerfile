# Base Python
FROM python:3.14.0-trixie

# WorkDir
WORKDIR /app

# Evitar criação de .pyc e buffer de saída 
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Dependências do sistema
# RUN apt-get update && apt-get install -y \
#    libpq-dev gcc curl netcat \
#    && rm -rf /var/lib/apt/lists/*

# Copiar dependências
COPY requirements.txt /app/

# Instalar dependências Python
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copiar todo o código
COPY . /app/

# Criar diretórios para arquivos estáticos e mídia
RUN mkdir -p /app/staticfiles /app/media

# Coletar estáticos (opcional, pode ser feito no start.sh)
# RUN python manage.py collectstatic --noinput

# Porta exposta (para Nginx)
EXPOSE 8000

# Comando padrão
CMD ["gunicorn", "serjuspi.wsgi:application", "--bind", "0.0.0.0:8000"]
