-module(tp3).

-export([q1/0, q2/0, q3/0, q4/0, q5/0, q6/0, q7/0, q8/2]).


%Films = [{id (rnd), titre (min 2 lettres), genre (enum), note moyenne (float), equipe (list acteurs separe par virgule), prix vente, nb exemplaires vendus, date production }].
films() -> [{1, "Film 1", "action", 7.0, ["a2","a3"], 10.99, 5000, {2017,01,01}}, {2, "Film 2", "action", 7.3, ["a2","a3"], 7.99, 4000, {2020,01,01}}, {3, "Film 3", "action", 4.7, ["a2","a3"], 9.99, 3000, {2019,01,01}}, {4, "Film 4", "action", 4.8, ["a1","a2","a3"], 8.99, 10000, {2019,01,01}}, {5, "Film 5", "action", 4.3, ["a1","a2","a3"], 9.99, 2500, {2019,01,01}}].

q1() -> 
	Films = films(),
	q1(1, 0, Films, []).
	
q1(FilmIndx, Max, Films, MaxFilms) ->

	Film = lists:nth(FilmIndx, Films),
	Price = element(6, Film),
	
	if
    Price > Max ->
        NewMax = Price,
        NewMaxFilms = [element(2, Film)];
    Price == Max ->
		NewMax = Max,
		NewMaxFilms = lists:append(MaxFilms, [element(2, Film)]);
    true ->
        NewMax = Max,
        NewMaxFilms = MaxFilms
    end,
    
    if 
	FilmIndx == length(Films) ->
		NewMaxFilms;
	true ->
		q1((FilmIndx + 1), NewMax, Films, NewMaxFilms)
	end.
	
q2() -> 
	Films = films(),
	q2(1, element(6, lists:nth(1, Films)), Films, []).
	
q2(FilmIndx, Min, Films, MinFilms) ->

	Film = lists:nth(FilmIndx, Films),
	Price = element(6, Film),
	
	if
    Price < Min ->
        NewMin = Price,
        NewMinFilms = [element(2, Film)];
    Price == Min ->
		NewMin = Min,
		NewMinFilms = lists:append(MinFilms, [element(2, Film)]);
    true ->
        NewMin = Min,
        NewMinFilms = MinFilms
    end,
    
    if 
	FilmIndx == length(Films) ->
		NewMinFilms;
	true ->
		q2((FilmIndx + 1), NewMin, Films, NewMinFilms)
	end.

q3() ->
	
	Films = films(),
	q3(1, Films, []).

q3(FilmIndx, Films, AdjustedFilms) -> 
	Film = lists:nth(FilmIndx, Films),
	{Id, Title, Genre, Rating, Cast, Price, NbSold, RelDate} = Film,
	
	if
	Rating > 7.0 ->
		NewPrice = Price + Price * 0.10,
		AdjustedFilm = {Id, Title, Genre, Rating, Cast, NewPrice, NbSold, RelDate},
		NewAdjustedFilms = lists:append(AdjustedFilms, [AdjustedFilm]);
	Rating =< 7.0 ->
		NewPrice = Price - Price * 0.05,
		AdjustedFilm = {Id, Title, Genre, Rating, Cast, NewPrice, NbSold, RelDate},
		NewAdjustedFilms = lists:append(AdjustedFilms, [AdjustedFilm]);
	true ->
		NewAdjustedFilms = AdjustedFilms
	end,
	
	if 
	FilmIndx == length(Films) ->
		NewAdjustedFilms;
	true ->
		q3((FilmIndx + 1), Films, NewAdjustedFilms)
	end.
	
q4() ->
	Films = films(),
	q4([], 1, Films).

q4(SortedFilms, FilmIndx, Films) ->
	CurFilm = lists:nth(FilmIndx, Films),
	
	NewSortedFilms = insert(CurFilm, SortedFilms, 1),
	
	if 
	FilmIndx == length(Films) ->
		NewSortedFilms;
	true ->
		q4(NewSortedFilms, FilmIndx + 1, Films)
	end.

insert(Film, [], _) ->
	[Film];

insert(Film, SortedFilms, SortedIndx) ->
	FilmPrice = element(6, Film),
	CurSortedFilm = lists:nth(SortedIndx, SortedFilms),
	SortedFilmPrice = element(6, CurSortedFilm),
	if
	FilmPrice > SortedFilmPrice ->
		{Left, Right} = lists:split(SortedIndx-1, SortedFilms),
		Left ++ [Film|Right];
	SortedIndx == length(SortedFilms) ->
		lists:append(SortedFilms, [Film]);
	true ->
		insert(Film, SortedFilms, SortedIndx + 1)
	end.

q5() -> 
	Films = films(),
	q5(1, 0, Films, []).
	
q5(FilmIndx, Max, Films, MaxFilms) ->

	Film = lists:nth(FilmIndx, Films),
	Price = element(6, Film),
	Qty = element(7, Film),
	
	Profit = Qty * Price,
	
	if
    Profit > Max ->
        NewMax = Profit,
        NewMaxFilms = [element(2, Film)];
    Profit == Max ->
		NewMax = Max,
		NewMaxFilms = lists:append(MaxFilms, [element(2, Film)]);
    true ->
        NewMax = Max,
        NewMaxFilms = MaxFilms
    end,
    
    if 
	FilmIndx == length(Films) ->
		NewMaxFilms;
	true ->
		q5((FilmIndx + 1), NewMax, Films, NewMaxFilms)
	end.
	
q6() ->
	Films = films(),
	q6(1, Films, []).
	
q6(FilmIndx, Films, Profits) ->
	Film = lists:nth(FilmIndx, Films),
	{_,_,_,_,_,Price,NbSold,_} = Film,
	
	NewProfits = lists:append(Profits, [Price * NbSold]),

	if 
	FilmIndx == length(Films) ->
		NewProfits;
	true ->
		q6((FilmIndx + 1), Films, NewProfits)
	end.

q7() ->
	Films = films(),
	Res = io:fread("Prompt> ","~s"),
	Name = lists:nth(1, element(2, Res)),
	q7(1, Films, [], Name).
	
q7(FilmIndx, Films, FilmsWithActor, ActorName) ->
	Film = lists:nth(FilmIndx, Films),
	IsMember = lists:member(ActorName, element(5, Film)),
	
	if
	IsMember ->
		NewFilmsWithActor = lists:reverse([Film] ++ FilmsWithActor);
	true ->
		NewFilmsWithActor = FilmsWithActor
	end,
	
	if
	FilmIndx == length(Films) ->
		NewFilmsWithActor;
	true ->
		q7(FilmIndx + 1, Films, NewFilmsWithActor, ActorName)
	end.
	
q8(D1, D2) ->
	Films = films(),
	
	q8(1, D1, D2, Films, []).
	
q8(FilmIndx, D1, D2, Films, FilmsInDates) ->
	{Id, Title, _, _, _, _, _, RelDate} = lists:nth(FilmIndx, Films),
	
	if 
	((D1 < D2) and ((RelDate >= D1) and (RelDate =< D2))) or ((D2 =< D1) and ((RelDate >= D2) and (RelDate < D1))) ->
		Film = {Id, Title},
		NewFilmsInDates = lists:append(FilmsInDates, [Film]);
	true ->
		NewFilmsInDates = FilmsInDates
	end,
	
	if 
	FilmIndx == length(Films) ->
		NewFilmsInDates;
	true ->
		q8((FilmIndx + 1), D1, D2, Films, NewFilmsInDates)
	end.
