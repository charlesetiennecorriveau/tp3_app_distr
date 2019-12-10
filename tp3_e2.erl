%% ----------------------------------
%% @author Jeremy Arsenault-Lavoie, Charles-Etienne Corriveau
%% @copyright 2019
%% @doc
%% @end
%% ----------------------------------

-module(tp3_e2).
-export([q1/0]).

%EXERCICE 2
q1() ->
	IP = io:fread("Please enter IP address> ", "~s"),
	try
		[A, B, C, D] = string:tokens(lists:nth(1, element(2, IP)), "."),
		
		IP1 = list_to_integer(A),
		IP2 = list_to_integer(B),
		IP3 = list_to_integer(C),
		IP4 = list_to_integer(D),
		
		if
		(IP1 >= 0) and (IP1 < 127) ->
			if
			(IP1 == 10) and (IP2 >= 0) and (IP2 < 256) and (IP3 >= 0) and (IP3 < 256) and (IP4 > 0) and (IP4 < 256) ->
				io:fwrite("adresse privee~n~.2B ~.2B ~.2B ~.2B~n", [IP1, IP2, IP3, IP4]);
			(IP2 >= 0) and (IP2 < 256) and (IP3 >= 0) and (IP3 < 256) and (IP4 > 0) and (IP4 < 255) ->
				io:fwrite("A~n~.2B ~.2B ~.2B ~.2B~n", [IP1, IP2, IP3, IP4]);
			true ->
				io:fwrite("erreur~n", [])
			end;
		(IP1 == 127) and (IP2 >= 0) and (IP2 < 256) and (IP3 >= 0) and (IP3 < 256) and (IP4 > 0) and (IP4 < 256) ->
			io:fwrite("boucle locale~n~.2B ~.2B ~.2B ~.2B~n", [IP1, IP2, IP3, IP4]);
		(IP1 > 127) and (IP1 < 192) ->
			if
			(IP1 == 172) and (IP3 > 15) and (IP3 < 32) and (IP4 >= 0) and (IP4 < 256) ->
				io:fwrite("adresse privee~n~.2B ~.2B ~.2B ~.2B~n", [IP1, IP2, IP3, IP4]);
			(IP2 >= 0) and (IP2 < 256) and (IP3 >= 0) and (IP3 < 256) and (IP4 > 0) and (IP4 < 255) ->
				io:fwrite("B~n~.2B ~.2B ~.2B ~.2B~n", [IP1, IP2, IP3, IP4]);
			true ->
				io:fwrite("erreur~n", [])
			end;
		(IP1 > 191) and (IP1 < 224) ->
			if
			(IP1 == 192) and (IP2 == 168) and (IP3 >= 0) and (IP3 < 256) and (IP4 > 0) and (IP4 < 256) ->
				io:fwrite("adresse privee~n~.2B ~.2B ~.2B ~.2B~n", [IP1, IP2, IP3, IP4]);
			(IP2 >= 0) and (IP2 < 256) and (IP3 >= 0) and (IP3 < 256) and (IP4 > 0) and (IP4 < 255) ->
				io:fwrite("C~n~.2B ~.2B ~.2B ~.2B~n", [IP1, IP2, IP3, IP4]);
			true ->
				io:fwrite("erreur~n", [])
			end;
		(IP1 > 223) and (IP1 < 240) and (IP2 >= 0) and (IP2 < 256) and (IP3 >= 0) and (IP3 < 256) and (IP4 >= 0) and (IP4 < 256) ->
			io:fwrite("D~n~.2B ~.2B ~.2B ~.2B~n", [IP1, IP2, IP3, IP4]);
		(IP1 > 239) and (IP1 < 248) and (IP2 >= 0) and (IP2 < 256) and (IP3 >= 0) and (IP3 < 256) and (IP4 >= 0) and (IP4 < 256) ->
			io:fwrite("E~n~.2B ~.2B ~.2B ~.2B~n", [IP1, IP2, IP3, IP4]);
		true ->
			io:fwrite("erreur~n", [])
		end
	catch _:_ ->
		io:fwrite("erreur~n", [])
	end.
