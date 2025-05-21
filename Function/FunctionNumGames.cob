       identification division.
       function-id.   FunctionNumGames.
      *author.       Paulo.
      *date-written. 15/02/2017.
      *remarks.      Calcula o fatorial do numero N informado via argumento.
      *Note.         FileName must be equal to 'function-id'
       environment division.
       configuration section.

       data division.
       working-storage section.
       77 ws-val                   pic 9(6).
       linkage section.
       01 lk-in                    pic 9(6).
       01 lk-out                   pic 9(6).

       procedure division using lk-in returning lk-out.
       main.
           compute lk-out = (lk-in - 1) * 2.
           goback.

       end function FunctionNumGames.
	  
