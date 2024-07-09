FROM bonitasoft/bonita-postgres:15.4
ENV POSTGRES_PASSWORD bpm

# Set max_prepared_transactions
CMD ["postgres", "-c", "max_prepared_transactions=100"]
CMD ["postgres", "-c", "max_connections=100"]