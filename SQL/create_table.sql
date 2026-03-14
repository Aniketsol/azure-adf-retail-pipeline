CREATE TABLE clean_products (
    product_id    INT,
    title         VARCHAR(255),
    price         DECIMAL(10,2),
    category      VARCHAR(100),
    rating_score  DECIMAL(3,1),
    rating_count  INT,
    loaded_at     DATETIME DEFAULT GETDATE()
);