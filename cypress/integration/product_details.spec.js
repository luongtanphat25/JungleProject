describe('Testing Product-page', () => {
  beforeEach(() => {
    cy.visit('/');
  });
  
  it('Click on the first product link', () => {
    cy.get('.products article:first-child a').click();
    cy.url().should('include', '/products/2');
  });
});
