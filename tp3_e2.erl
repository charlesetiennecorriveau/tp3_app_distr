%% ----------------------------------
%% @author Jeremy Arsenault-Lavoie, Charles-Etienne Corriveau
%% @copyright 2019
%% @doc
%% @end
%% ----------------------------------

-module(tp3_e2).
-export([q1/0, q2_1/0, q2_2/0]).

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
q2_1() ->
	Addresses = "193.188.127.0-193.188.127.255(Bahrain);193.188.64.0-193.188.95.255(Jordan);194.126.32.0-194.126.63.255(Kuwait);194.165.128.0-194.165.159.255(Jordan);194.170.0.0-194.170.255.255(United Arab Emirates);194.54.192.0-194.54.255.255(Kuwait);195.174.0.0-195.175.255.255(Turkey);195.226.224.0-195.226.255.255(Kuwait);195.229.0.0-195.229.255.255(United Arab Emirates);195.39.128.0-195.39.191.255(Kuwait);203.135.32.0-203.135.63.255(Pakistan);203.215.64.0-203.215.95.255(Philippines)",
	SplitAddresses = string:tokens(Addresses, ";"),
	Fun = fun(S) -> 
		{_, [_, {A, B}, {C, D}, {E, F}]} = re:run(S, "(\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3})-(\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3})\\(([\\w ]+)\\)"),
		{string:slice(S, A, B), string:slice(S, C, D), string:slice(S, E, F)}
	end, 
	Regex = lists:map(Fun, SplitAddresses),
	
	{_, [Address]} = io:fread("Entrez une addresse IP : ", "~s"),
	getCountry(Regex, 1, Address).
addressIsBetween(Address, Lower, Upper) ->
	[AA, AB, AC, AD] = string:tokens(Address, "."),
	[UA, UB, UC, UD] = string:tokens(Upper, "."),
	[LA, LB, LC, LD] = string:tokens(Lower, "."),

	NumberIsBetween = fun(A, U, L) ->
		try
			list_to_integer(L) =< list_to_integer(A) andalso list_to_integer(A) =< list_to_integer(U)
		catch _:_ ->
			io:fwrite("Error", [])
		end
	end,

	NumberIsBetween(AA, UA, LA) andalso NumberIsBetween(AB, UB, LB) andalso NumberIsBetween(AC, UC, LC) andalso NumberIsBetween(AD, UD, LD).
getCountry(Regex, Count, IP) ->
	if 
		Count > length(Regex) -> 
			"Inconnu";
		true ->
			% io:fwrite("~w~n", [Regex]),
			{Lower, Upper, Country} = lists:nth(Count, Regex),
			case addressIsBetween(IP, Lower, Upper) of
				true -> Country;
				% false -> getCountry(Regex, Count + 1, IP)
				false -> getCountry(Regex, Count + 1, IP)
			end
	end.

q2_2() ->
	{_, [Str1]} = io:fread("Entrez une chaine de 32 caractÃ¨res : ", "~s"),
	{_, [Str2]} = io:fread("Entrez une chaine de 32 caractÃ¨res : ", "~s"),
	if
		(length(Str1) == 32) andalso (length(Str2) == 32) ->
			toIP(opAnd(Str1, Str2));
		true ->
			io:fwrite("Erreur : Les deux chaines de caractÃ¨res doivent Ãªtre de 32 caractÃ¨res", [])
	end.
	
opAnd(Str1, Str2) ->
	if
		(length(Str1) == 0) or (length(Str2) == 0) ->
			"";
		true ->
			[H1|T1] = string:reverse(Str1),
			[H2|T2] = string:reverse(Str2),
			case ([H1] == "1") andalso ([H2] == "1") of
				true ->
					Val = "1";
				false ->
					Val = "0"
			end,
			opAnd(string:reverse(T1), string:reverse(T2))++Val
	end.

toIP(S) ->
	N1 = toDecimal(string:slice(S, 0, 8)),
	N2 = toDecimal(string:slice(S, 8, 8)),
	N3 = toDecimal(string:slice(S, 16, 8)),
	N4 = toDecimal(string:slice(S, 24, 8)),
	lists:flatten(io_lib:format("~p.~p.~p.~p", [N1, N2, N3, N4])).

toDecimal([]) ->
	0;
toDecimal(S) ->
	[H|T] = S,
	if
		[H] == "1" ->
			round(math:pow(2, length(T))) + toDecimal(T);
		true -> toDecimal(T)
	end.
