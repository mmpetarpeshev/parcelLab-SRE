FROM python:3.8-alpine

# Add a non-root user with a home directory
RUN adduser -D -h /home/parcel parcel

# Switch to root temporarily to install system dependencies
USER root
RUN apk --no-cache add build-base libffi-dev
USER parcel

# Create and set the working directory with proper permissions
RUN mkdir -p /home/parcel/app && chown -R parcel:parcel /home/parcel
WORKDIR /home/parcel/app

# Copy only the necessary files
COPY app.py .
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port on which the Flask app will run
EXPOSE 5000

# Command to run the application
CMD ["python", "app.py"]
