/*
 *
 * Defines file for expression routine.
 *
 * This files lists the first prioritisation of how the
 * different kinds of expressions are evaluated.
 *
 * MG Sep 09, 1990: Initial version.
 * HP Apr 17, 1992: Added lots of expression results; more or less needed.
 *
 */

/*
 * Result of expressions
 */
/* The expression evaluated to a fully known number */
#define     EXPFULLOK       (0)
/* The expression included a division by zero of some kind */
#define     EXPDIVZ         (51)
/* There was an undeclared identifier in the expression */
#define     EXPMISLAB       (52)
/* There was a syntax error in the expression */
#define     EXPSYNTAX       (53)
/* The expression included a reference to an identifier declared as extern */
#define     EXPEXTERN       (54)
/* The value of the expression is relative to the segment 'exprseg' (char *) */
#define     EXPSEGREL       (55)
/* The expression had unevaluable arithmetic with segments (treat as extern) */
#define     EXPSEGARIT      (56)
/*The expression had a reference to (and seems) a direct page declared extern*/
#define     EXPEXTERNZPAG   (57)
/* The expression is segment relative, but it is known to be direct page */
#define     EXPSEGZPAG      58

/* 
 * The values below must not clash with those above, but are used in a slightly
 * different context
 */
#define     FOLLOW          (-1)
