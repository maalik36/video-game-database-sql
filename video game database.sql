video_games_tb = "create table video_games (
id int primary key,
name varchar(50),
game_genre varchar(50),
game_developer varchar(50),
release_date varchar(255)
)"
game_developers_tb = "create table game_developers(
id int primary key,
name varchar(50),
address varchar(50),
state varchar(50),
city varchar(50),
country varchar(50)
)"
platforms_tb = "create table platforms(
id int primary key,
name varchar(50),
company_id int,
company varchar(50),
release_date varchar(50),
original_price float
)"
platforms_games_tb = "create table platforms_games(
game_id int,
platform_id int,
platform_name varchar(50),
constraint fk_video foreign key (game_id)
references video_games(id),
constraint fk_platform foreign key (platform_id)
references platforms(id),
constraint id primary key (game_id, platform_id)
)"
characters_tb = "create table characters(
id int primary key,
name varchar(50),
birthday varchar(50),
gender real,
info varchar(50)
)"
games_characters_tb = "create table games_characters(
character_id int,
character_name varchar(50),
game_id int,
constraint fk_character foreign key (character_id)
references characters(id),
constraint fk_game foreign key (game_id)
references video_games(id),
constraint id primary key (character_id, game_id)
)"
delete_rows = "delete from games_characters
where character_id is null;"
alter_table_platforms = "update platforms set release_date = date(release_date)"
alter_table_characters = "update characters set birthday = date(birthday)"
search_nathan = "select * from games_characters where character_name = 'Nathan Drake'"
how_many_people = "select count(*) from characters where info like '%Nathan Drake%'"
find_location = "select address, state, city, country from game_developers where name = (select game_developer from video_games where id = (select game_id from games_characters where character_name = 'Nathan Drake'));"
count_games_ca = "select count(*) from video_games where game_developer in (select name from game_developers where state = 'California')"
address =  "select address, state, city, country
from game_developers
where name =
    (select game_developers.name
    from game_developers
    inner join video_games on video_games.game_developer = game_developers.name
    where state = (select state
            from game_developers
            
            group by state order by count(state) desc)
        
    order by release_date desc)"