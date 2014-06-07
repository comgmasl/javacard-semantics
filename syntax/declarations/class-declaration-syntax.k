require "../modifiers-syntax.k"
require "../exp-syntax.k"
require "../statement-syntax.k"
require "../predefined-id-syntax.k"

module CLASS-DECLARATION-SYNTAX
	imports MODIFIERS-SYNTAX
	imports EXP-SYNTAX
	imports STATEMENT-SYNTAX
	imports PREDEFINED-ID-SYNTAX
	
  syntax Decl ::= "class" Id Block                
    	          | "class" Id "extends" Id Block   

  syntax Decl ::= Modifier "class" Id Block
	     	        | Modifier "class" Id "extends" Id Block
		            | Modifier "class" Id "implements" Exps Block
		            | Modifier "class" Id "extends" Id "implements" Exps Block
		            | "class" Id Block
		            | "class" Id "extends" Id Block
		            | "class" Id "implements" Exps Block
		            | "class" Id "extends" Id "implements" Exps Block
		      
		            | Modifier "abstract" "class" Id Block
		            | Modifier "abstract" "class" Id "extends" Id Block
		            | Modifier "abstract" "class" Id "implements" Exps Block
		            | Modifier "abstract" "class" Id "extends" Id "implements" Exps Block
		        
		            | "abstract" "class" Id Block
		            | "abstract" "class" Id "extends" Id Block
		            | "abstract" "class" Id "implements" Exps Block
		            | "abstract" "class" Id "extends" Id "implements" Exps Block

		            | Modifier "static" "class" Id Block
		            | Modifier "static" "class" Id "extends" Id Block
		            | Modifier "static" "class" Id "implements" Exps Block
		            | Modifier "static" "class" Id "extends" Id "implements" Exps Block
		            | "static" "class" Id Block
		            | "static" "class" Id "extends" Id Block
		            | "static" "class" Id "implements" Exps Block
		            | "static" "class" Id "extends" Id "implements" Exps Block
              
		            | Modifier "final" "class" Id Block
		            | Modifier "final" "class" Id "extends" Id Block
		            | Modifier "final" "class" Id "implements" Exps Block
		            | Modifier "final" "class" Id "extends" Id "implements" Exps Block
		            | "final" "class" Id Block
		            | "final" "class" Id "extends" Id Block
		            | "final" "class" Id "implements" Exps Block
		            | "final" "class" Id "extends" Id "implements" Exps Block
		              
		            | Modifier "static" "final" "class" Id Block
		            | Modifier "static" "final" "class" Id "extends" Id Block
		            | Modifier "static" "final" "class" Id "implements" Exps Block
		            | Modifier "static" "final" "class" Id "extends" Id "implements" Exps Block
		            | "static" "final" "class" Id Block
		            | "static" "final" "class" Id "extends" Id Block
		            | "static" "final"  "class" Id "implements" Exps Block
		            | "static" "final" "class" Id "extends" Id "implements" Exps Block
		              
		            | Modifier "final" "static" "class" Id Block
		            | Modifier "final" "static" "class" Id "extends" Id Block
		            | Modifier "final" "static" "class" Id "implements" Exps Block
		            | Modifier "final" "static" "class" Id "extends" Id "implements" Exps Block
		            | "final" "static" "class" Id Block
		            | "final" "static" "class" Id "extends" Id Block
		            | "final" "static" "class" Id "implements" Exps Block
		            | "final" "static" "class" Id "extends" Id "implements" Exps Block
		          
		            | Modifier Static Final Abst "class" Id "extends" Id "implements" Exps Block 
		            | Modifier Static Final Abst "class" Id "extends" Id Block




  /* ****************************************************************************************** */
  // *                                            * //
  // *                                            * //
  /* ****************************************************************************************** */

  rule M:Modifier class Class1:Id Bl:Block => M nonstatic nonfinal nonabstract class Class1 extends Object Bl             
  

  rule M class Class1 extends Class2 Bl => M nonstatic nonfinal nonabstract class Class1 extends Class2 Bl
  
  rule class Class1:Id Bl:Block => private nonstatic nonfinal nonabstract class Class1 extends Object Bl              
  
  rule class Class1:Id extends Class2:Id Bl:Block => private nonstatic nonfinal nonabstract class Class1 extends Class2 Bl

      
  /* ****************************************************************************************** */
  // *                                            * //
  // *                                            * //
  /* ****************************************************************************************** */  

  rule M abstract class Class1:Id Bl => M nonstatic nonfinal abstract class Class1 extends Object Bl
  
  rule M abstract class Class1:Id extends Class2:Id Bl:Block => M nonstatic nonfinal abstract class Class1 extends Class2 Bl
  
  rule abstract class Class1:Id Bl => public nonstatic nonfinal abstract class Class1 extends Object Bl
  
  rule abstract class Class1:Id extends Class2:Id Bl:Block => public nonstatic nonfinal abstract class Class1 extends Class2 Bl
  

  /* ****************************************************************************************** */
  // *                                            * //
  // *                                            * //
  /* ****************************************************************************************** */


  rule M:Modifier static class Class1:Id Bl:Block => M static nonfinal nonabstract class Class1 extends Object Bl 

  rule static class Class1:Id Bl:Block => public static nonfinal nonabstract class Class1 extends Object Bl             
  
  rule static class Class1:Id extends Class2:Id Bl:Block => public static nonfinal nonabstract class Class1 extends Class2 Bl      
  

  /* ****************************************************************************************** */
  // *                                            * //
  // *                                            * //
  /* ****************************************************************************************** */

  rule M:Modifier final class Class1:Id Bl:Block => M nonstatic final nonabstract class Class1 extends Object Bl              
  
  rule final class Class1:Id Bl:Block => private nonstatic final nonabstract class Class1 extends Object Bl             
  
  rule final class Class1:Id extends Class2:Id Bl:Block => private nonstatic final nonabstract class Class1 extends Class2 Bl 
  

  /* ****************************************************************************************** */
  // *                                            * //
  // *                                            * //
  /* ****************************************************************************************** */    
  

  rule M:Modifier static final class Class1:Id Bl:Block => M static final nonabstract class Class1 extends Object Bl              
  
  rule static final class Class1:Id Bl:Block => public static final nonabstract class Class1 extends Object Bl              
  
  rule static final class Class1:Id extends Class2:Id Bl:Block => public static final nonabstract 
  class Class1 extends Class2 Bl  
            
  /* ****************************************************************************************** */
  // *                                            * //
  // *                                            * //
  /* ****************************************************************************************** */    
  

  rule M:Modifier final static class Class1:Id Bl:Block => M static final nonabstract class Class1 extends Object Bl              
  
  rule final static class Class1:Id Bl:Block => public static final nonabstract class Class1 extends Object Bl              
  
  rule final static class Class1:Id extends Class2:Id Bl:Block => public static final nonabstract class Class1 extends Class2 Bl  

  /* ****************************************************************************************** */
  // *                                            * //
  // *                                            * //
  /* ****************************************************************************************** */

  rule M class Class1 implements Es Bl => M nonstatic nonfinal nonabstract class Class1 extends Object implements Es Bl
  
  rule M class Class1 extends Class2 implements Es Bl => M nonstatic nonfinal nonabstract class Class1 extends Class2 implements Es Bl  
  
  rule class Class1 implements Es Bl => private nonstatic nonfinal nonabstract class Class1 extends Object implements Es Bl
  
  rule class Class1 extends Class2 implements Es Bl => private nonstatic nonfinal nonabstract class Class1 extends Class2 implements Es Bl  
  
  /* ****************************************************************************************** */
  // *                                            * //
  // *                                            * //
  /* ****************************************************************************************** */


  rule M abstract class Class1 implements Es Bl => M nonstatic nonfinal abstract class Class1 extends Object implements Es Bl
  
  rule M abstract class Class1 extends Class2 implements Es Bl => M nonstatic nonfinal abstract class Class1 extends Class2 implements Es Bl  
  
  rule abstract class Class1 implements Es Bl => public nonstatic nonfinal abstract class Class1 extends Object implements Es Bl
  
  rule abstract class Class1 extends Class2 implements Es Bl => public nonstatic nonfinal abstract class Class1 extends Class2 implements Es Bl 
      

  /* ****************************************************************************************** */
  // *                                            * //
  // *                                            * //
  /* ****************************************************************************************** */
      
  rule M static class Class1 implements Es Bl => M static nonfinal nonabstract class Class1 extends Object implements Es Bl
  
  rule M static class Class1 extends Class2 implements Es Bl => M static nonfinal nonabstract class Class1 extends Class2 implements Es Bl  
  
  rule static class Class1 implements Es Bl => public static nonfinal nonabstract class Class1 extends Object implements Es Bl
  
  rule static class Class1 extends Class2 implements Es Bl => public static nonfinal nonabstract class Class1 extends Class2 implements Es Bl 

    
  /* ****************************************************************************************** */
  // *                                            * //
  // *                                            * //
  /* ****************************************************************************************** */

  rule M final class Class1 implements Es Bl => M nonstatic final nonabstract class Class1 extends Object implements Es Bl
  
  rule M final class Class1 extends Class2 implements Es Bl => M nonstatic final nonabstract 
  class Class1 extends Class2 implements Es Bl  
  
  rule final class Class1 implements Es Bl => private nonstatic final nonabstract class Class1 extends Object implements Es Bl
  
  rule final class Class1 extends Class2 implements Es Bl => private nonstatic final nonabstract class Class1 extends Class2 implements Es Bl 
      
  
  /* ****************************************************************************************** */
  // *                                            * //
  // *                                            * //
  /* ****************************************************************************************** */

  rule M static final class Class1 implements Es Bl => M static final nonabstract class Class1 extends Object implements Es Bl
  
  rule M static final class Class1 extends Class2 implements Es Bl => M static final nonabstract 
  class Class1 extends Class2 implements Es Bl  
  
  rule static final class Class1 implements Es Bl => public static final nonabstract class Class1 extends Object implements Es Bl
  
  rule static final class Class1 extends Class2 implements Es Bl => public static final nonabstract class Class1 extends Class2 implements Es Bl  
      

  /* ****************************************************************************************** */
  // *                                                                              * //
  // *                                                                              * //
  /* ****************************************************************************************** */
      
  rule M final static class Class1 implements Es Bl => M static final nonabstract class Class1 extends Object implements Es Bl
  
  rule M final static class Class1 extends Class2 implements Es Bl => M static final nonabstract class Class1 extends Class2 implements Es Bl 
  
  rule final static class Class1 implements Es Bl => public static final nonabstract class Class1 
  extends Object implements Es Bl
  
  rule final static class Class1 extends Class2 implements Es Bl => public static final nonabstract class Class1 extends Class2 implements Es Bl  


endmodule