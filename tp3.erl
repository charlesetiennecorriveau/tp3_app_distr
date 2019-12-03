-module(tp3).
-export([q1/0,q4/0]).


%Films = [{id (rnd), titre (min 2 lettres), genre (enum), note moyenne (float), equipe (list acteurs separe par virgule), prix vente, nb exemplaires vendus, date production }].
films() -> [{1, "Film 1", "action", 4.5, ["a 1","a 2","a 3"], 8.99, 5000, "2019-01-01"}, {2, "Film 2", "action", 4.6, ["a 1","a 2","a 3"], 10.99, 4000, "2019-01-01"}, {3, "Film 3", "action", 4.7, ["a 1","a 2","a 3"], 9.99, 3000, "2019-01-01"}, {4, "Film 4", "action", 4.8, ["a 1","a 2","a 3"], 9.99, 10000, "2019-01-01"}, {5, "Film 5", "action", 4.3, ["a 1","a 2","a 3"], 9.99, 2500, "2019-01-01"}].

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
		
	
