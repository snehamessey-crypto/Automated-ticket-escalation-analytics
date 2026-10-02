import pandas as pd
import numpy as np

# Load dataset
df = pd.read_csv('customer_support_tickets.csv')

# Clean headers
df.columns = [c.strip().replace(' ', '_').lower() for c in df.columns]

# Target description column
text_col = 'ticket_description'
df[text_col] = df[text_col].astype(str).str.lower()

# Rule-based category assignment
def categorize_ticket(text):
    if any(k in text for k in ['refund', 'charged', 'charge', 'money', 'billing', 'invoice', 'payment']):
        return 'Billing & Refund'
    elif any(k in text for k in ['broken', 'damaged', 'repair', 'maintenance', 'equipment', 'machine', 'defect']):
        return 'Equipment & Maintenance'
    elif any(k in text for k in ['trainer', 'coach', 'instructor', 'schedule', 'timing', 'slot', 'class']):
        return 'Staff & Scheduling'
    else:
        return 'General Query'

# Urgency tagger
def detect_urgency(text):
    if any(k in text for k in ['urgent', 'emergency', 'immediately', 'legal', 'scam', 'worst', 'injury', 'danger']):
        return 'Critical'
    elif any(k in text for k in ['refund', 'broken', 'delay', 'issue', 'failed']):
        return 'High'
    else:
        return 'Medium'

df['complaint_category'] = df[text_col].apply(categorize_ticket)
df['urgency_level'] = df[text_col].apply(detect_urgency)

# Export processed dataset
df.to_csv('tickets_processed_clean.csv', index=False)
print("Processing complete: tickets_processed_clean.csv exported.")
