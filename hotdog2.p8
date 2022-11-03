pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
function _init()
	create_player()
	prouts={}
end

function _update()
	player_movement()
	interact()
	update_prouts()
end

function _draw()
	cls()
	draw_map()
	draw_player()
	draw_prouts()
	draw_ui()
end
-->8
--map

function draw_map()
	map(0,0,0,0,128,64)
end

function check_flag(flag,x,y)
	local sprite=mget(x,y)
	return fget(sprite,flag)
end

--pick up hot dog
function next_tile(x,y)
	sprite=mget(x,y)
	mset(x,y,sprite+1)
end


function pick_hotdog(x,y)
	next_tile(x,y)
	p.hotdogs+=1
	sfx(0)
end
-->8
--player

function create_player()
	p={
		x=7,
		y=8,
		sprite=32,
		hotdogs=0
	}
end

function player_movement()
	newx=p.x
	newy=p.y
	if (btnp(➡️)) newx+=1
	if (btnp(⬅️)) newx-=1
	if (btnp(⬇️)) newy+=1
	if (btnp(⬆️)) newy-=1
	
	interact(newx,newy)
	
	if not check_flag(0,newx,newy) then
		p.x=mid(0,newx,15)
		p.y=mid(0,newy,15)
	end
end

function interact(x,y)
	if check_flag(1,x,y) then
		pick_hotdog(x,y)
		create_prout(p.x*8,p.y*8)
	end
end

function draw_player()
	spr(p.sprite,p.x*8,p.y*8)
end
-->8
--prouts
function create_prout(x,y)
	sfx(1)
	add(prouts,{x=x,
	            y=y,
	            timer=0})
end

function update_prouts()
	for pr in all(prouts) do
		pr.timer+=1
		if pr.timer==13 then
			del(prouts,pr)
		end
	end
end

function draw_prouts()
	circ(x,y,rayon,couleur)
	
	for pr in all(prouts) do
		circ(pr.x,pr.y,pr.timer/3,
							4+pr.timer%3)
	end
end

-->8
--ui

function draw_ui()
	palt(0,false)
	palt(12,true)
	spr(48,2,2)
	print_outline("X"..p.hotdogs,10,3)
end

function print_outline(text,x,y)
	print(text,x-1,y,0)	
	print(text,x+1,y,0)
	print(text,x,y-1,0)
	print(text,x,y+1,0)
	print(text,x,y,7)	
end
__gfx__
00000000999499943333333333333333333b333399949994999499949994999444444444444444444444444433333334333333334333333344444444333b3334
00000000444444443333e333333333333b3333b34000000440000004400000444333333333333333333333343333333433333333433333333b3333b33b3333b4
0070070049994999333eae3333333333333333334009400940094999400940094333333333333333333333343333333433333333433333333333333333333334
00077000444444443333e33333333333b333b333400440044004444440000004433333333333333333333334333333343333333343333333b333b333b333b334
000770009994999433e333333333333333b3333b90000004900499949004990443333333333333333333333433333334333333334333333333b3333b33b33334
00700700444444443eae333333333333333333334000000440000004400444044333333333333333333333343333333433333333433333333333333333333334
000000004999499933e33333333333333b33b3334009400940000009400000994333333333333333333333343333333433333333433333333b33b3333b33b334
00000000444444443333333333333333333333b3444444444444444444444444433333333333333333333334333333344444444443333333333333b3333333b4
433b3333444444443333333433333333433333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4b3333b33333e3333333e3343333e3334333e3330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
43333333333eae33333eae34333eae33433eae330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4333b3333333e3333333e3343333e3334333e3330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
43b3333b33e3333333e3333433e3333343e333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
433333333eae33333eae33343eae33334eae33330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4b33b33333e3333333e3333433e3333343e333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
433333b3333333333333333444444444433333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
33ffff3333ffff333333333333333333000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3471f173371f17433333988333333333000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
44fff455554fff44333948a333333333000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
44ff44444444ff44339a8a4333333333000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
443883e33e3883443948849333333333000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
33fffa3333afff333884993333333333000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3ffff333333ffff338a9933333333333000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
f39f39333393f93f3333333333333333000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
cc009880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
c00978a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
009a8a40000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
09488490000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
08849900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
08a9900c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000cc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__label__
3333333399949994333333333333333333333333333b333399949994333333339994999499949994999499943333333399949994333333333333333333333333
333333334444444433333333333333333333e3333b3333b344444444333333334444444444444444444444443333e33344444444333333333333333333333333
33333333499949993333333333333333333eae33333333334999499933333333499949994999499949994999333eae3349994999333333333333333333333333
333333334444444433333333333333333333e333b333b33344444444333333334444444444444444444444443333e33344444444333333333333333333333333
3333333399949994333333333333333333e3333333b3333b999499943333333399949994999499949994999433e3333399949994333333333333333333333333
333333334444444433333333333333333eae33333333333344444444333333334444444444444444444444443eae333344444444333333333333333333333333
3333333349994999333333333333333333e333333b33b333499949993333333349994999499949994999499933e3333349994999333333333333333333333333
3333333344444444333333333333333333333333333333b344444444333333334444444444444444444444443333333344444444333333333333333333333333
333b333399949994999499943333333399949994999499949994999433333333333333333333333399949994333b333399949994333333339994999499949994
3b3333b34444444444444444333333334444444444444444444444443333e3333333333333333333444444443b3333b344444444333333334444444444444444
33333333499949994999499933333333499949994999499949994999333eae333333333333333333499949993333333349994999333333334999499949994999
b333b3334444444444444444333333334444444444444444444444443333e333333333333333333344444444b333b33344444444333333334444444444444444
33b3333b99949994999499943333333399949994999499949994999433e3333333333333333333339994999433b3333b99949994333333339994999499949994
333333334444444444444444333333334444444444444444444444443eae33333333333333333333444444443333333344444444333333334444444444444444
3b33b33349994999499949993333333349994999499949994999499933e333333333333333333333499949993b33b33349994999333333334999499949994999
333333b344444444444444443333333344444444444444444444444433333333333333333333333344444444333333b344444444333333334444444444444444
33333333333333339994999433333333999499943333333333333333333b3333999499943333333333333333333333339994999433333333333b333333333333
3333e3333333333344444444333333334444444433333333333333333b3333b34444444433333333333333333333333344444444333333333b3333b33333e333
333eae333333333349994999333333334999499933333333333333333333333349994999333333333333333333333333499949993333333333333333333eae33
3333e333333333334444444433333333444444443333333333333333b333b333444444443333333333333333333333334444444433333333b333b3333333e333
33e3333333333333999499943333333399949994333333333333333333b3333b99949994333333333333333333333333999499943333333333b3333b33e33333
3eae333333333333444444443333333344444444333333333333333333333333444444443333333333333333333333334444444433333333333333333eae3333
33e333333333333349994999333333334999499933333333333333333b33b3334999499933333333333333333333333349994999333333333b33b33333e33333
33333333333333334444444433333333444444443333333333333333333333b3444444443333333333333333333333334444444433333333333333b333333333
99949994333333333333333333333333999499943333333399949994999499949994999433333333999499943333333399949994999499949994999499949994
4444444433333333333333333333e33344444444333333334444444444444444444444443333e333444444443333333344444444444444444444444444444444
499949993333333333333333333eae334999499933333333499949994999499949994999333eae33499949993333333349994999499949994999499949994999
4444444433333333333333333333e33344444444333333334444444444444444444444443333e333444444443333333344444444444444444444444444444444
99949994333333333333333333e33333999499943333333399949994999499949994999433e33333999499943333333399949994999499949994999499949994
4444444433333333333333333eae333344444444333333334444444444444444444444443eae3333444444443333333344444444444444444444444444444444
49994999333333333333333333e33333499949993333333349994999499949994999499933e33333499949993333333349994999499949994999499949994999
44444444333333333333333333333333444444443333333344444444444444444444444433333333444444443333333344444444444444444444444444444444
999499943333333399949994333b33339994999499949994999499943333333399949994333b3333999499943333333333333333333333333333333333333333
4444444433333333444444443b3333b344444444444444444444444433333333444444443b3333b3444444443333333333333333333333333333333333333333
49994999333333334999499933333333499949994999499949994999333333334999499933333333499949993333333333333333333333333333333333333333
444444443333333344444444b333b3334444444444444444444444443333333344444444b333b333444444443333333333333333333333333333333333333333
99949994333333339994999433b3333b999499949994999499949994333333339994999433b3333b999499943333333333333333333333333333333333333333
44444444333333334444444433333333444444444444444444444444333333334444444433333333444444443333333333333333333333333333333333333333
4999499933333333499949993b33b33349994999499949994999499933333333499949993b33b333499949993333333333333333333333333333333333333333
444444443333333344444444333333b34444444444444444444444443333333344444444333333b3444444443333333333333333333333333333333333333333
99949994333333339994999433333333333333333333333399949994333333339994999433333333333333333333333399949994333333339994999499949994
444444443333333344444444333333333333333333333333444444443333e3334444444433333333333333333333e33344444444333333334444444444444444
49994999333333334999499933333333333333333333333349994999333eae33499949993333333333333333333eae3349994999333333334999499949994999
444444443333333344444444333333333333333333333333444444443333e3334444444433333333333333333333e33344444444333333334444444444444444
9994999433333333999499943333333333333333333333339994999433e3333399949994333333333333333333e3333399949994333333339994999499949994
444444443333333344444444333333333333333333333333444444443eae33334444444433333333333333333eae333344444444333333334444444444444444
4999499933333333499949993333333333333333333333334999499933e3333349994999333333333333333333e3333349994999333333334999499949994999
44444444333333334444444433333333333333333333333344444444333333334444444433333333333333333333333344444444333333334444444444444444
99949994333333339994999433333333999499949994999499949994333b3333999499943333333399949994333b333399949994333333333333333333333333
444444443333333344444444333333334444444444444444444444443b3333b34444444433333333444444443b3333b344444444333333333333333333333333
49994999333333334999499933333333499949994999499949994999333333334999499933333333499949993333333349994999333333333333333333333333
44444444333333334444444433333333444444444444444444444444b333b333444444443333333344444444b333b33344444444333333333333333333333333
9994999433333333999499943333333399949994999499949994999433b3333b99949994333333339994999433b3333b99949994333333333333333333333333
44444444333333334444444433333333444444444444444444444444333333334444444433333333444444443333333344444444333333333333333333333333
499949993333333349994999333333334999499949994999499949993b33b3334999499933333333499949993b33b33349994999333333333333333333333333
44444444333333334444444433333333444444444444444444444444333333b3444444443333333344444444333333b344444444333333333333333333333333
99949994333333339994999433333333999499943333333333333333333333339994999499949994999499949994999499949994333333339994999499949994
44444444333333334444444433333333444444443333333333333333333333334444444444444444444444444444444444444444333333334444444444444444
49994999333333334999499933333333499949993333333333333333333333334999499949994999499949994999499949994999333333334999499949994999
44444444333333334444444433333333444444443333333333333333333333334444444444444444444444444444444444444444333333334444444444444444
99949994333333339994999433333333999499943333333333333333333333339994999499949994999499949994999499949994333333339994999499949994
44444444333333334444444433333333444444443333333333333333333333334444444444444444444444444444444444444444333333334444444444444444
49994999333333334999499933333333499949993333333333333333333333334999499949994999499949994999499949994999333333334999499949994999
44444444333333334444444433333333444444443333333333333333333333334444444444444444444444444444444444444444333333334444444444444444
99949994333333339994999433333333999499943333333333ffff333333333333333333333b3333333333333333333333333333333333333333333399949994
4444444433333333444444443333333344444444333333333471f17333333333333333333b3333b33333e3333333333333333333333333333333333344444444
49994999333333334999499933333333499949993333333344fff455333333333333333333333333333eae333333333333333333333333333333333349994999
44444444333333334444444433333333444444443333333344ff44443333333333333333b333b3333333e3333333333333333333333333333333333344444444
999499943333333399949994333333339994999433333333443883e3333333333333333333b3333b33e333333333333333333333333333333333333399949994
44444444333333334444444433333333444444443333333333fffa333333333333333333333333333eae33333333333333333333333333333333333344444444
4999499933333333499949993333333349994999333333333ffff33333333333333333333b33b33333e333333333333333333333333333333333333349994999
444444443333333344444444333333334444444433333333f39f39333333333333333333333333b3333333333333333333333333333333333333333344444444
333b3333333333339994999433333333999499943333333399949994999499949994999499949994999499949994999499949994333333339994999499949994
3b3333b33333e3334444444433333333444444443333333344444444444444444000000440000004400000044000004444444444333333334444444444444444
33333333333eae334999499933333333499949993333333349994999499949994009400940094999400940094009400949994999333333334999499949994999
b333b3333333e3334444444433333333444444443333333344444444444444444004400440044444400440044000000444444444333333334444444444444444
33b3333b33e333339994999433333333999499943333333399949994999499949000000490049994900000049004990499949994333333339994999499949994
333333333eae33334444444433333333444444443333333344444444444444444000000440000004400000044004440444444444333333334444444444444444
3b33b33333e333334999499933333333499949993333333349994999499949994009400940000009400940094000009949994999333333334999499949994999
333333b3333333334444444433333333444444443333333344444444444444444444444444444444444444444444444444444444333333334444444444444444
999499949994999499949994333333339994999433333333999499943333333333333333333333333333333333333333333333333333333333333333333b3333
44444444444444444444444433333333444444443333333344444444333333333333333333333333333333333333333333333333333333333333e3333b3333b3
4999499949994999499949993333333349994999333333334999499933333333333333333333333333333333333333333333333333333333333eae3333333333
44444444444444444444444433333333444444443333333344444444333333333333333333333333333333333333333333333333333333333333e333b333b333
999499949994999499949994333333339994999433333333999499943333333333333333333333333333333333333333333333333333333333e3333333b3333b
44444444444444444444444433333333444444443333333344444444333333333333333333333333333333333333333333333333333333333eae333333333333
499949994999499949994999333333334999499933333333499949993333333333333333333333333333333333333333333333333333333333e333333b33b333
444444444444444444444444333333334444444433333333444444443333333333333333333333333333333333333333333333333333333333333333333333b3
9994999433333333333333333333333333333333333b333399949994333333339994999499949994999499943333333399949994999499949994999499949994
444444443333333333333333333333333333e3333b3333b3444444443333e3334444444444444444444444443333333344444444444444444444444444444444
49994999333333333333333333333333333eae333333333349994999333eae334999499949994999499949993333333349994999499949994999499949994999
444444443333333333333333333333333333e333b333b333444444443333e3334444444444444444444444443333333344444444444444444444444444444444
9994999433333333333333333333333333e3333333b3333b9994999433e333339994999499949994999499943333333399949994999499949994999499949994
444444443333333333333333333333333eae333333333333444444443eae33334444444444444444444444443333333344444444444444444444444444444444
4999499933333333333333333333333333e333333b33b3334999499933e333334999499949994999499949993333333349994999499949994999499949994999
4444444433333333333333333333333333333333333333b344444444333333334444444444444444444444443333333344444444444444444444444444444444
99949994333b33339994999499949994999499943333333399949994333b333333333333333333339994999433333333333b3333333333333333333399949994
444444443b3333b344444444444444444444444433333333444444443b3333b33333333333333333444444443333e3333b3333b3333333333333333344444444
4999499933333333499949994999499949994999333333334999499933333333333333333333333349994999333eae3333333333333333333333333349994999
44444444b333b3334444444444444444444444443333333344444444b333b3333333333333333333444444443333e333b333b333333333333333333344444444
9994999433b3333b999499949994999499949994333333339994999433b3333b33333333333333339994999433e3333333b3333b333333333333333399949994
44444444333333334444444444444444444444443333333344444444333333333333333333333333444444443eae333333333333333333333333333344444444
499949993b33b33349994999499949994999499933333333499949993b33b33333333333333333334999499933e333333b33b333333333333333333349994999
44444444333333b34444444444444444444444443333333344444444333333b333333333333333334444444433333333333333b3333333333333333344444444
99949994333333339994999433333333333333333333333399949994999499949994999499949994999499949994999499949994999499949994999499949994
444444443333e3334444444433333333333333333333333344444444444444444444444444444444444444444444444444444444444444444444444444444444
49994999333eae334999499933333333333333333333333349994999499949994999499949994999499949994999499949994999499949994999499949994999
444444443333e3334444444433333333333333333333333344444444444444444444444444444444444444444444444444444444444444444444444444444444
9994999433e333339994999433333333333333333333333399949994999499949994999499949994999499949994999499949994999499949994999499949994
444444443eae33334444444433333333333333333333333344444444444444444444444444444444444444444444444444444444444444444444444444444444
4999499933e333334999499933333333333333333333333349994999499949994999499949994999499949994999499949994999499949994999499949994999
44444444333333334444444433333333333333333333333344444444444444444444444444444444444444444444444444444444444444444444444444444444
333333333333333333333333333b33339994999433333333333b3333333333333333333333333333333333333333333333333333333b33333333333333333333
3333333333333333333333333b3333b344444444333333333b3333b33333e33333333333333333333333333333333333333333333b3333b33333e33333333333
33333333333333333333333333333333499949993333333333333333333eae33333333333333333333333333333333333333333333333333333eae3333333333
333333333333333333333333b333b3334444444433333333b333b3333333e3333333333333333333333333333333333333333333b333b3333333e33333333333
33333333333333333333333333b3333b999499943333333333b3333b33e33333333333333333333333333333333333333333333333b3333b33e3333333333333
333333333333333333333333333333334444444433333333333333333eae33333333333333333333333333333333333333333333333333333eae333333333333
3333333333333333333333333b33b33349994999333333333b33b33333e3333333333333333333333333333333333333333333333b33b33333e3333333333333
333333333333333333333333333333b34444444433333333333333b3333333333333333333333333333333333333333333333333333333b33333333333333333
99949994999499949994999433333333999499949994999499949994999499949994999499949994999499943333333399949994999499949994999499949994
4444444444444444444444443333e333444444444444444444444444444444444444444444444444444444443333333344444444444444444444444444444444
499949994999499949994999333eae33499949994999499949994999499949994999499949994999499949993333333349994999499949994999499949994999
4444444444444444444444443333e333444444444444444444444444444444444444444444444444444444443333333344444444444444444444444444444444
99949994999499949994999433e33333999499949994999499949994999499949994999499949994999499943333333399949994999499949994999499949994
4444444444444444444444443eae3333444444444444444444444444444444444444444444444444444444443333333344444444444444444444444444444444
49994999499949994999499933e33333499949994999499949994999499949994999499949994999499949993333333349994999499949994999499949994999
44444444444444444444444433333333444444444444444444444444444444444444444444444444444444443333333344444444444444444444444444444444

__gff__
0001000000010101000000000000000000000000000000000000000000000000000002000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
08010909110e0109010101110122090a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1001010301010102030301040103010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1403010301030304010303030103011200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0122030201030101010201030103010f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0103010401010103010401030303030b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0103010303030102010303020103010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0103010301010104010301040122030b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0103032201030303010101010103010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0103010301030103030402030303030100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1002010301030101050605070103010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010301030103030303030303020f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0103030302040102010101030101030100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0104010101030104030301020403030100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0102010303030101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d03030401030402030303030304020b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
01010113010101010101010c0101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000200000d2500c2500a2500925008250072500625005250032500025000200002000020000200002000020000200002000020000200002000020000200002000020000200002000020000200002000020000200
