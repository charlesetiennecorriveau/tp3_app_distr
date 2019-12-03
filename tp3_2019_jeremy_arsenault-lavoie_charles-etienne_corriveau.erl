-module(tp3).
-export([q1/0, q2/0, q3/0, q4/0, q5/0, q6/0, q7/0, q8/0]).

%Films = [{id (rnd), titre (min 2 lettres), genre (enum), note moyenne (float), equipe (list acteurs separe par virgule), prix vente, nb exemplaires vendus, date production }].
Films = [{1, "Film 1", action, 4.5, ["a 1","a 2","a 3",], 9.99, 5000, date}, {2, "Film 2", action, 4.6, ["a 1","a 2","a 3",], 9.99, 4000, date}, {3, "Film 3", action, 4.7, ["a 1","a 2","a 3",], 9.99, 3000, date}, {4, "Film 4", action, 4.8, ["a 1","a 2","a 3",], 9.99, 10000, date}, {5, "Film 5", action, 4.3, ["a 1","a 2","a 3",], 9.99, 2500, date}]
q1() ->
	
