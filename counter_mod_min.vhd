library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_mod_min is
	generic (n     : natural := 60;        
           width : natural :=6
			  );
	port (signal reset_n :  in std_logic;
        signal clk     :  in std_logic;
        signal en      :  in std_logic;
		  signal sel     :  in std_logic_vector(1 downto 0);
        signal q       : out std_logic_vector(width-1 downto 0)
		  );
end counter_mod_min;

architecture structural_3 of counter_mod_min is

  signal q_reg   : unsigned(width-1 downto 0);
  signal q_next  : unsigned(width-1 downto 0);
  signal q_in  : unsigned(width-1 downto 0);
  
begin
  selection: process (sel)
  begin
	  if (sel = "00") then
			q_in <= "000101";
	  elsif (sel = "01") then
			q_in <= "011001";
	  elsif (sel = "10") then
			q_in <= "111011";
	  elsif (sel = "11") then
			q_in <= "101010";
	  end if;
  end process selection;
  
  seq: process(reset_n,clk)
  begin
    if (reset_n = '0') then
      q_reg <= q_in;
    elsif rising_edge(clk) then
      q_reg <= q_next;  
    end if;
  end process seq;

  comb: process(en, q_reg)
  begin
    if (en = '1') then
	  --if (q_reg = to_unsigned(n-1,q_reg'length)) then
	  if (q_reg = "000000") then
	    q_next <= q_in;
	  else	
	    q_next <= q_reg - 1;
	  end if; 	
	else
	  q_next <= q_reg;
    end if;
  end process comb;
  
  q <= std_logic_vector(q_reg); 
  
end structural_3;
