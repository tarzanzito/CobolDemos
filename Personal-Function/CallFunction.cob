       identification division.
       program-id. CallFunction.
      *author.       Paulo.
      *date-written. 15/02/2017.
      *remarks.      Call Function.
       environment division.
       configuration section.
       repository.
      *Use fileName (dll extension) 
           function FunctionNumGames.

       data division.
       working-storage section.
       77 ws-n pic 9(6) value zeros.
	   
       procedure division.
       main.
           display "Enter num times (or zero to quit):".
           accept ws-n from console.
           if ws-n = zeros
               stop run
           else
               display "Num games in " ws-n " times is:"
               display FunctionNumGames(ws-n)
           end-if.
           go to main.
		   
      *   stop run.
      *
	  
