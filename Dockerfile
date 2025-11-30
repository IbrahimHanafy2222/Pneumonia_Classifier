# 1. Use a lightweight Python base
FROM python:3.9-slim

# 2. Set the working directory inside the container
WORKDIR /app

# 3. Copy the dependency file first (for caching)
COPY requirements.txt .

# 4. Install dependencies
# We use --no-cache-dir to keep the image small
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copy the rest of your code (app.py, model files, etc)
COPY . .

# 6. Expose the port (Render usually looks for port 10000 or 5000)
EXPOSE 5000

# 7. Start the app using Gunicorn
# 'app:app' means 'file_named_app:variable_named_app'
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]
