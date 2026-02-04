-- =====================================================
-- Topic: Seed Data - Payments
-- File: seed/seed_payments.sql
-- =====================================================

INSERT INTO Payment (RentalID, Amount, PaymentMethod)
VALUES
(1, 10.50, 'Card'),
(2, 15.00, 'Cash'),
(3, 12.00, 'Card');

INSERT INTO Payment (RentalID, Amount, PaymentMethod)
VALUES
(7, 11.00, 'Card'),
(8, 13.00, 'Cash'),
(9, 15.00, 'Card'),
(10, 12.50, 'Card'),
(11, 14.00, 'Cash');
