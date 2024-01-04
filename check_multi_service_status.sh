#!/bin/bash


  # Array of services to monitor.
  services=("ssh" "http" "mysql")

  # Empty array for services that are not active.
  non_running=()

  # A variable that holds the file name.
  logfile="service_status.log"


  echo "Start checking the status of services..."
  echo $(date +"%Y-%m-%d %T") >> $logfile

  # Loop to check the status of each service
  for ((i=1; i<4; i++)); do
      echo "Attempt $i" >> $logfile
      for service in "${services[@]}"; do
          if systemctl is-active --quiet $service; then
              echo "$service is running." >> $logfile
          else
              echo "$service is not running." >> $logfile
              # Add the service to another array of non-running services
              non_running+=("$service")
          fi
      done
      # Pause for 10 seconds
      sleep 10
  done

  # Send an email if any services were found to be non-running
  if [ ${#non_running[@]} -gt 0 ]; then
      echo "The following services are not running: ${non_running[*]}" | mail -s "Alert: Non-Running Services Detected" amir_ahmadinami@outlook.com >/dev/null 2>&1
      if [ $? -eq 0 ]; then
         echo "Email successfully sent to $email_address." | tee -a $logfile
      else
         echo "Error: There was a problem sending the email." | tee -a  $logfile
      fi
  fi
echo "The reports were written to the $logfile file."
