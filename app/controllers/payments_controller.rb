# Pseudo-code for unit tests using Pytest

def test_upgrade_button_visible():
    response = client.get('/submission/detail/1')  # Assuming submission ID is 1
    assert response.status_code == 200
    assert 'Upgrade' in response.data

def test_redirect_to_stripe_checkout():
    response = client.post('/submission/upgrade/1')  # Assuming submission ID is 1
    assert response.status_code == 302  # Check for redirect
    assert response.headers['Location'] == 'https://checkout.stripe.com/pay/checkout_session_id'  # Replace with actual session ID

def test_successful_payment_updates_status():
    submission = Submission.objects.get(id=1)
    submission.status = 'Free'
    submission.save()
    
    process_payment(submission.id)  # Simulate payment processing
    submission.refresh_from_db()
    assert submission.status == 'Priority'

def test_email_confirmation_sent():
    submission = Submission.objects.get(id=1)
    assert len(mail.outbox) == 1
    assert mail.outbox[0].subject == 'Payment Confirmation'

def test_priority_polling_flag():
    submission = Submission.objects.get(id=1)
    assert submission.polling_interval == 6  # Check if the interval is set to 6 hours