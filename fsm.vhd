library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fsm is 
	port(
		reset_n, clk, en, config , ini_pausa, jugador_act, min_value_j0, min_value_j1 : in std_logic;
		mov_j0_gt40, mov_j1_gt40: in std_logic;
		modo: in std_logic_vector(1 downto 0);
		ini_pausa_j0, borrar_j0, en_j0, ini_pausa_j1, borrar_j1, en_j1, en_sel: out std_logic
	);
end fsm;

library ieee;
use ieee.std_logic_1164.all;

architecture comportamental of fsm is

type estados is (ST_IDLE,ST_WAIT_CONFIG, ST_PLAYERS_CONFIG, ST_PLAYER_0_P, ST_PLAYER_1_P, ST_PLAYER_0, ST_PLAYER_1, ST_PLAYER_0_L, ST_PLAYER_1_L , ST_PLAYER_0_M, ST_PLAYER_1_M);
signal estado_presente, estado_siguiente : estados;

begin

     process(clk, reset_n, estado_siguiente)

     begin

        if reset_n = '0' then
             estado_presente <= ST_IDLE;
        elsif rising_edge(clk) then
             if en = '1' then
					estado_presente <= estado_siguiente;
				 end if;
         end if;
      end process;

     process(estado_presente, config, ini_pausa, modo, jugador_act, min_value_j0, min_value_j1)
     begin
        case (estado_presente) is
   when ST_IDLE =>
			ini_pausa_j0 <='0';
			borrar_j0 <='1';
			ini_pausa_j1 <='0';
			borrar_j1 <='1';
			en_sel <='0';
			en_j0 <='0';
			en_j1 <='0';
		if config ='1' then
			estado_siguiente <= ST_WAIT_CONFIG;
		else
			estado_siguiente <= ST_IDLE;
		end if;
			
	when ST_WAIT_CONFIG => 
			ini_pausa_j0 <='0';
			borrar_j0 <='0';
			ini_pausa_j1 <='0';
			borrar_j1 <='0';
			en_sel <='1';
			en_j0 <='0';
			en_j1 <='0';
		if config ='0' then
			estado_siguiente <= ST_PLAYERS_CONFIG;
		else
			estado_siguiente <= ST_WAIT_CONFIG;
		end if;
									
	when ST_PLAYERS_CONFIG =>
			ini_pausa_j0<='0';
			borrar_j0<='0';
			ini_pausa_j1<='0';
			borrar_j1<='0';
			en_sel <='0';
			en_j0 <='0';
			en_j1 <='0';
		if (ini_pausa ='1' and jugador_act ='0') then
			estado_siguiente <= ST_PLAYER_0_P;
		elsif (ini_pausa ='1' and jugador_act ='1') then
			estado_siguiente <= ST_PLAYER_1_P;
		else
			estado_siguiente <= ST_PLAYERS_CONFIG;
		end if;
									 
	when ST_PLAYER_0_P => 
			ini_pausa_j0 <='0';
			borrar_j0 <='0';
			ini_pausa_j1 <='0';
			borrar_j1 <='0';
			en_sel <='0';
			en_j0 <='0';
			en_j1 <='0';
		if ini_pausa ='1'  then
			estado_siguiente <= ST_PLAYER_0;
		else
			estado_siguiente <= ST_PLAYER_0_P;
		end if;
									 
	when ST_PLAYER_0 =>
			ini_pausa_j0<='1';
			borrar_j0<='0';
			ini_pausa_j1<='0';
			borrar_j1<='0';
			en_sel <='0';
			en_j0 <='0';
			en_j1 <='0';
		if jugador_act ='1'  then
			estado_siguiente <= ST_PLAYER_0_M;
		elsif min_value_j0='1' then
			estado_siguiente <= ST_PLAYER_0_L;
		elsif ini_pausa ='0' then 
			estado_siguiente <= ST_PLAYER_0_P;
		else
			estado_siguiente <= ST_PLAYER_0;
		end if;
									 
	when ST_PLAYER_0_L => 
			ini_pausa_j0<='0';
			borrar_j0<='0';
			ini_pausa_j1<='0';
			borrar_j1<='0';
			en_sel <='0';
			en_j0 <='0';
			en_j1 <='0';
			estado_siguiente <= ST_PLAYER_0_L;
	
	when ST_PLAYER_1_P   =>
			ini_pausa_j0 <='0';
			borrar_j0 <='0';
			ini_pausa_j1 <='0';
			borrar_j1 <='0';
			en_sel <='0';
			en_j0 <='0';
			en_j1 <='0';	
		if ini_pausa ='1'  then
			estado_siguiente <= ST_PLAYER_1;
		else
			estado_siguiente <= ST_PLAYER_1_P;
		end if;
									 
	when ST_PLAYER_1    => 
			ini_pausa_j0 <='0';
			borrar_j0 <='0';
			ini_pausa_j1 <='1';
			borrar_j1 <='0';
			en_sel <='0';
			en_j0 <='0';
			en_j1 <='0';
		if jugador_act ='0'  then
			estado_siguiente <= ST_PLAYER_1_M;
		elsif min_value_j1 ='1' then
			estado_siguiente <= ST_PLAYER_1_L;
		elsif ini_pausa ='0' then 
			estado_siguiente <= ST_PLAYER_1_P;
		else
			estado_siguiente <= ST_PLAYER_1;
		end if;
									 
	when ST_PLAYER_1_L => 
			ini_pausa_j0 <='0';
			borrar_j0 <='0';
			ini_pausa_j1 <='0';
			borrar_j1 <='0';
			en_sel <='0';
			en_j0 <='0';
			en_j1 <='0';
			estado_siguiente <= ST_PLAYER_1_L;
	
	
	when ST_PLAYER_0_M =>   
			ini_pausa_j0 <='0';
			borrar_j0 <='0';
			ini_pausa_j1 <='1';
			borrar_j1 <='0';
			en_sel <='0';
			en_j0 <='1';
			en_j1 <='0';
			estado_siguiente <= ST_PLAYER_1;
	
	when ST_PLAYER_1_M =>  
			ini_pausa_j0 <='1';
			borrar_j0 <='0';
			ini_pausa_j1 <='0';
			borrar_j1 <='0';
			en_sel <='0';
			en_j0 <='0';
			en_j1 <='1';
			estado_siguiente <= ST_PLAYER_0;
	
	when others => 			
			ini_pausa_j0 <='-';
			borrar_j0 <='-';
			ini_pausa_j1 <='-';
			borrar_j1 <='-';
			en_sel <='-';
			en_j0 <='-';
			en_j1 <='-';
			estado_siguiente <=	ST_IDLE ;
        end case;
     end process;
end comportamental;