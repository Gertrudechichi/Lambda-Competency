EC2 Instance Cost Optimization Project

Overview

This project aims to optimize the cost of EC2 instances in production environments by automating their start and stop times. By leveraging a serverless architecture, EC2 instances will only run during working hours (8am-10pm), reducing unnecessary costs.

Use Cases

- Document processing workloads with predictable schedules
- Generating invoices for customers
- Processing payment transactions
- Creating contract documents
- Sending notifications to stakeholders
- Automating daily reports or website updates

Architecture

- Cross-Account AWS Architecture: A Lambda function in the serverless service provider's account controls EC2 instances in the client account.
- Scheduled Automation: Amazon EventBridge triggers the Lambda function on a cron schedule.
- Secure Cross-Account Management: The Lambda function assumes an IAM role using STS to gain temporary permissions.

Implementation

- AWS Serverless Application Model (SAM): Used to define infrastructure components in a template.yaml file.
- Streamlined Deployment: SAM minimizes errors during deployment.

Benefits

- Cost Optimization: Reduce EC2 instance costs by automating start and stop times.
- Increased Efficiency: Automate document processing workloads during regular business hours.
- Secure and Scalable: Leverage AWS services for secure and scalable architecture.

Get Started

- Watch the accompanying YouTube video for a step-by-step guide on deploying this solution: [link to YouTube video]
- Follow the instructions in the video to set up the project in your AWS account.
- Clone this repository to explore the project code and architecture.
replace this with emojis
