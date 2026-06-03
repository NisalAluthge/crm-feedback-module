-- ============================================================
-- Customer Feedback Module - PostgreSQL Initialization Script
-- CRM Enterprise System
-- ============================================================

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Drop table if exists (for clean re-init)
DROP TABLE IF EXISTS customer_feedback;

-- ============================================================
-- MAIN TABLE: customer_feedback
-- ============================================================
CREATE TABLE customer_feedback (
    feedback_id   UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    customer_id   VARCHAR(64)  NOT NULL,
    rating        SMALLINT     NOT NULL CHECK (rating BETWEEN 1 AND 5),
    category      VARCHAR(64)  NOT NULL CHECK (
        category IN (
            'Product Quality',
            'Customer Support',
            'Delivery & Shipping',
            'Pricing & Value',
            'Website & App',
            'Returns & Refunds',
            'Other'
        )
    ),
    comments      TEXT,
    created_at    TIMESTAMPTZ  NOT NULL DEFAULT NOW()
);

-- Indexes for CRM query patterns
CREATE INDEX idx_cf_customer_id  ON customer_feedback (customer_id);
CREATE INDEX idx_cf_category     ON customer_feedback (category);
CREATE INDEX idx_cf_rating       ON customer_feedback (rating);
CREATE INDEX idx_cf_created_at   ON customer_feedback (created_at DESC);

-- ============================================================
-- MOCK DATA — 40 realistic rows
-- ============================================================
INSERT INTO customer_feedback (customer_id, rating, category, comments, created_at) VALUES
-- Product Quality
('CRM-1001', 5, 'Product Quality',     'Absolutely love the build quality. Exceeded my expectations completely.', NOW() - INTERVAL '1 day'),
('CRM-1002', 4, 'Product Quality',     'Very solid product. Minor cosmetic issue on arrival but works perfectly.', NOW() - INTERVAL '2 days'),
('CRM-1003', 3, 'Product Quality',     'Average quality for the price point. Expected a bit more durability.', NOW() - INTERVAL '3 days'),
('CRM-1004', 5, 'Product Quality',     'Premium feel, excellent materials. Will definitely reorder.', NOW() - INTERVAL '4 days'),
('CRM-1005', 2, 'Product Quality',     'Product stopped working after two weeks. Quite disappointed.', NOW() - INTERVAL '5 days'),
('CRM-1006', 4, 'Product Quality',     'Good quality overall. Packaging was impressive too.', NOW() - INTERVAL '6 days'),

-- Customer Support
('CRM-1007', 5, 'Customer Support',    'Agent resolved my issue in under 5 minutes. Outstanding service!', NOW() - INTERVAL '1 day'),
('CRM-1008', 1, 'Customer Support',    'Waited 3 hours on hold and still no resolution. Very frustrating.', NOW() - INTERVAL '2 days'),
('CRM-1009', 4, 'Customer Support',    'Friendly and knowledgeable staff. Issue was resolved promptly.', NOW() - INTERVAL '3 days'),
('CRM-1010', 3, 'Customer Support',    'Response was okay but I had to follow up twice to get a final answer.', NOW() - INTERVAL '4 days'),
('CRM-1011', 5, 'Customer Support',    'Exceptional support team. They went above and beyond to help me.', NOW() - INTERVAL '5 days'),
('CRM-1012', 2, 'Customer Support',    'Felt like I was talking to a script. No personalised help at all.', NOW() - INTERVAL '7 days'),

-- Delivery & Shipping
('CRM-1013', 5, 'Delivery & Shipping', 'Arrived 2 days early and packaging was pristine. Perfect delivery!', NOW() - INTERVAL '1 day'),
('CRM-1014', 3, 'Delivery & Shipping', 'Delivery was on time but box was slightly damaged on arrival.', NOW() - INTERVAL '2 days'),
('CRM-1015', 1, 'Delivery & Shipping', 'Order took 3 weeks longer than estimated. No proactive communication.', NOW() - INTERVAL '3 days'),
('CRM-1016', 4, 'Delivery & Shipping', 'Fast delivery and well-packaged. Happy with the experience.', NOW() - INTERVAL '4 days'),
('CRM-1017', 5, 'Delivery & Shipping', 'Same-day delivery worked flawlessly. Very impressed.', NOW() - INTERVAL '5 days'),
('CRM-1018', 2, 'Delivery & Shipping', 'Package was left in the rain. Contents were slightly damp.', NOW() - INTERVAL '8 days'),

-- Pricing & Value
('CRM-1019', 4, 'Pricing & Value',     'Great value for money. Competitive pricing compared to alternatives.', NOW() - INTERVAL '1 day'),
('CRM-1020', 5, 'Pricing & Value',     'Best price I found anywhere. Quality matched the cost perfectly.', NOW() - INTERVAL '2 days'),
('CRM-1021', 2, 'Pricing & Value',     'Felt overpriced for what was delivered. Expected more at this tier.', NOW() - INTERVAL '3 days'),
('CRM-1022', 3, 'Pricing & Value',     'Fair price but competitors offer slightly better deals on bundles.', NOW() - INTERVAL '5 days'),
('CRM-1023', 4, 'Pricing & Value',     'Promotional pricing was fantastic. Will watch for future sales.', NOW() - INTERVAL '9 days'),
('CRM-1024', 5, 'Pricing & Value',     'Loyalty discount applied correctly and saved me a lot. Thank you!', NOW() - INTERVAL '10 days'),

-- Website & App
('CRM-1025', 5, 'Website & App',       'The new UI redesign is clean and intuitive. Love the dark mode!', NOW() - INTERVAL '1 day'),
('CRM-1026', 4, 'Website & App',       'Very smooth checkout flow. Mobile experience is excellent.', NOW() - INTERVAL '2 days'),
('CRM-1027', 2, 'Website & App',       'App crashed twice during checkout. Lost my cart both times.', NOW() - INTERVAL '4 days'),
('CRM-1028', 3, 'Website & App',       'Search functionality could be improved. Results are not always relevant.', NOW() - INTERVAL '6 days'),
('CRM-1029', 5, 'Website & App',       'Tracking page is real-time and beautifully designed. Great job!', NOW() - INTERVAL '11 days'),
('CRM-1030', 1, 'Website & App',       'Website was completely down for 4 hours during my order attempt.', NOW() - INTERVAL '12 days'),

-- Returns & Refunds
('CRM-1031', 5, 'Returns & Refunds',   'Refund was processed within 24 hours. No questions asked. Brilliant!', NOW() - INTERVAL '1 day'),
('CRM-1032', 3, 'Returns & Refunds',   'Return process is a bit complex. Needed to fill too many forms.', NOW() - INTERVAL '2 days'),
('CRM-1033', 1, 'Returns & Refunds',   'Still waiting for refund after 3 weeks. Totally unacceptable.', NOW() - INTERVAL '3 days'),
('CRM-1034', 4, 'Returns & Refunds',   'Easy return label generation online. Refund in 5 business days.', NOW() - INTERVAL '5 days'),
('CRM-1035', 2, 'Returns & Refunds',   'Was offered store credit instead of cash refund without asking me.', NOW() - INTERVAL '13 days'),

-- Other
('CRM-1036', 4, 'Other',              'Overall great experience. Would recommend to colleagues.', NOW() - INTERVAL '1 day'),
('CRM-1037', 3, 'Other',              'Nothing specific to complain about, but nothing stood out either.', NOW() - INTERVAL '2 days'),
('CRM-1038', 5, 'Other',              'Remarkable improvement over the last 6 months. Keep it up!', NOW() - INTERVAL '3 days'),
('CRM-1039', 2, 'Other',              'Communication after purchase was lacking. Felt ignored post-sale.', NOW() - INTERVAL '4 days'),
('CRM-1040', 4, 'Other',              'Loyalty programme is excellent. Points system is transparent and fair.', NOW() - INTERVAL '6 days');
