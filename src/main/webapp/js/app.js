document.addEventListener('DOMContentLoaded', () => {
    // 1. Confirm Delete Actions
    const deleteButtons = document.querySelectorAll('.btn-delete-confirm');
    deleteButtons.forEach(btn => {
        btn.addEventListener('click', (e) => {
            const name = btn.getAttribute('data-name') || 'this employee';
            if (!confirm(`Are you sure you want to delete ${name}? This action cannot be undone.`)) {
                e.preventDefault();
            }
        });
    });

    // 2. Format Salary Values
    const salaryElements = document.querySelectorAll('.format-salary');
    salaryElements.forEach(el => {
        const val = parseFloat(el.textContent);
        if (!isNaN(val)) {
            el.textContent = new Intl.NumberFormat('en-US', {
                style: 'currency',
                currency: 'USD',
                maximumFractionDigits: 0
            }).format(val);
        }
    });

    // 3. Auto-dismiss Alerts
    const alerts = document.querySelectorAll('.alert-danger, .error-msg');
    if (alerts.length > 0) {
        setTimeout(() => {
            alerts.forEach(alert => {
                alert.style.transition = 'opacity 0.5s ease';
                alert.style.opacity = '0';
                setTimeout(() => alert.remove(), 500);
            });
        }, 5000); // 5 seconds
    }
});
