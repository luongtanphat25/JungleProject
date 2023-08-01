describe('Add to cart', () => {
  beforeEach(() => {
    cy.visit('/');
  });

  it('There is products on the page', () => {
    cy.get('.button_to:eq(0)>[type="submit"]').click({ force: true });
    cy.get('.nav-link:eq(5)').should('include.text', `My Cart (1)`);
  });

  it('should increase the cart count when a product is added', () => {
    // Get the initial cart count from the cart button text
    cy.get('.nav-link').contains('My Cart').invoke('text')
      .then((initialCartText) => {
        const initialCartCount = parseInt(
          initialCartText.match(/\d+/)[0],
          10
        );

        // Click the first "Add to Cart" button on the home page
        cy.get('article').eq(0).find('button[type="submit"]').click({force:true});

        // Get the updated cart count from the cart button text
        cy.get('.nav-link').contains('My Cart').invoke('text')
          .then((updatedCartText) => {
            const updatedCartCount = parseInt(
              updatedCartText.match(/\d+/)[0],
              10
            );

            // Check if the cart count has increased by one
            expect(updatedCartCount).to.equal(initialCartCount + 1);
          });
      });
  });
});
