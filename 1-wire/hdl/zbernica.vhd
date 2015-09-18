--vyhladavanie viacerych zariadeni na zbernici 24.2.2015

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity zbernica is
port (
            signal clk      : IN STD_LOGIC;
            signal reset   : IN STD_LOGIC;
            --pamatove signaly
            signal address   : IN STD_LOGIC_VECTOR(1 downto 0);
            signal readdata   : OUT STD_LOGIC_VECTOR(7 downto 0);
            signal writedata: IN STD_LOGIC_VECTOR(7 downto 0);
            signal write   : IN STD_LOGIC;
            signal chipselect   : IN STD_LOGIC;
            --outwire vystup
            signal onewire      : INOUT STD_LOGIC
            );
end entity zbernica;

architecture arch of zbernica is

  signal sample_count          :std_logic_vector(4 downto 0);
  signal rst_count             :std_logic_vector(3 downto 0);
  signal tx_count             :std_logic_vector(2 downto 0);
  signal rx_count             :std_logic_vector(3 downto 0);
  signal rx_register          :std_logic_vector(7 downto 0);
  signal tx_register          :std_logic_vector(7 downto 0);
  signal clk_predivider         :std_logic_vector(7 downto 0);
  signal clk_counter         :std_logic_vector(7 downto 0);
  signal crc               :std_logic_vector(7 downto 0);

  signal rst_i                :std_logic;
  signal presense             :std_logic;
  signal rst_slot             :std_logic;
  signal rx_slot              :std_logic; 
  signal tx_slot              :std_logic;  
  signal busy                 :std_logic;
  signal crcpoly              :std_logic;
  signal inwire               :STD_LOGIC;
  signal outwire              :STD_LOGIC;
  signal bit_mode             :std_logic;
  signal bit_valid            :std_logic;
  
  
   constant RX_DATA         :std_logic_vector(1 downto 0) := "00";
   constant STATUS_CONTROL  :std_logic_vector(1 downto 0) := "01";
   constant TX_DATA         :std_logic_vector(1 downto 0) := "10";
   constant CLOCK           :std_logic_vector(1 downto 0) := "10";   

 begin
   
busy <= rst_slot or tx_slot or rx_slot ;
crcpoly <= (inwire xor crc(7));
onewire <= '0' when outwire='0' else 'Z';
inwire <= onewire;
   
process(clk)
begin
   if reset = '1' or rst_i ='1' then
      sample_count <= (others =>'0');
      tx_count <= (others =>'0');
      rx_count <= (others =>'0');
      tx_register <= (others =>'0');
      readdata <= (others => '0');
      crc <= (others => '0');
      rx_register <= (others => '0');
      rx_slot <='0';
      tx_slot <='0';
      bit_mode <='0';
      bit_valid <='0';
      rst_slot <='0';
      rst_i <='0';
      presense <='0';
      outwire <='1';
   elsif rising_edge(clk) then
-------------------------------------------------------------------------------------------------------------
---------------avalon read ---- citanie pomocou avalon zbernice----------------------------------------------
-------------------------------------------------------------------------------------------------------------      
      if(chipselect = '1' and write='0') then
         case address is
            when RX_DATA =>
               readdata <= rx_register;
            when STATUS_CONTROL =>
               readdata(0) <= presense;
               readdata(1) <= rx_slot;
               readdata(2) <= tx_slot;
               readdata(3) <= rst_slot;
               readdata(4) <= bit_mode;
               --readdata(5) <= interupt;
               readdata(6) <= busy;
               readdata(7) <= bit_valid;
            when TX_DATA =>
               readdata <= crc;
            when others =>
               readdata <= clk_predivider;
         end case;
      end if;
-------------------------------------------------------------------------------------------------------------
------------------avalon write ---zapis z avalon zbernice----------------------------------------------------
-------------------------------------------------------------------------------------------------------------
      if chipselect = '1' and write='1' then
         case address is
            when RX_DATA =>
               --rx_register <= writedata;
            when STATUS_CONTROL =>
               presense <= writedata(0);
               rx_slot <= writedata(1);
               tx_slot <= writedata(2);
               rst_slot <= writedata(3);
               bit_mode <= writedata(4);               
               --interupt <= writedata(5);
               --rst_done <= writedata(6);
               rst_i <= writedata(7);
            when TX_DATA =>               
               tx_register <= writedata;
            when others =>
               clk_predivider <= writedata;
         end case;
      end if;
   
--------------------------------------------------------------------------------------------------------------
------------------------signalizacia--------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------
----------------------preddelenie hodinovych impulzov---------------------------------------------------------
      if clk_counter >= clk_predivider then
         clk_counter <= (others =>'0');
--------------------------------------------------------------------------------------------------------------
--------------vysielanie reset slotu a cakanie na presense----------------------------------------------------
         if rst_slot='1' then
            if sample_count = 31 then
               sample_count <= (others => '0') ;
               rst_count <= rst_count+1;
               if rst_count = 7 then
                  outwire <='1';
               elsif rst_count = 8 and inwire ='0' then
                  presense<='1';
               elsif rst_count >= 15 then
                  rst_slot <='0';
               end if;
            else
               sample_count<=sample_count+1;
               if rst_count < 7 then
                  outwire <='0';
               end if;
            end if;
         end if;
--------------------------------------------------------------------------------------------------------------
----------------vysielanie dat--------------------------------------------------------------------------------
         if presense='1' and tx_slot='1' and rst_slot='0' and bit_mode='0' then
            if tx_register(0)='1' then
               case sample_count is--vypisovanie log 1
                  when "00000" =>
                     outwire <='0';
                  when others =>
                     outwire <='1';
               end case;
            else
               case sample_count is--vypisovanie log 0
                  when "11110"|"11111" =>
                     outwire <='1';
                  when others =>
                     outwire <='0';
               end case;
            end if;
            sample_count <= sample_count+1;
            if sample_count = 31 then
               tx_register <= '0' & tx_register(7 downto 1);
               tx_count <= tx_count+1;
               if tx_count = 7 then
                  tx_slot <='0';
                  outwire <='1';
               end if;
            end if;
         end if;
--------------------------------------------------------------------------------------------------------------
-------------ciatanie na zbernici-----------------------------------------------------------------------------
         if rx_slot='1' and tx_slot='0' and rst_slot='0' and bit_mode='0' then
            case sample_count is
               when "00000" => --generovanie "hodinoveho start impuzu"
                  outwire <= '0';
               when "00101" =>
                  rx_register <= inwire & rx_register(7 downto 1) ;
                  rx_count <= rx_count+1;
                  crc <= crc(6 downto 5) & (crcpoly xor crc(4)) & (crcpoly xor crc(3)) & crc (2 downto 0) & crcpoly ;
               when "11111" =>
                  if rx_count >= 8 then
                     rx_count <= (others => '0') ;
                     rx_slot <='0';-------------------------------------------------
                  end if;
               when others =>
                  outwire <='1';
            end case;
            sample_count <= sample_count+1;
         end if;
--------------------------------------------------------------------------------------------------------------
----------------hladanie slave zariadeni na zbernici (bit_mod)------------------------------------------------
--------------------------------------------------------------------------------------------------------------
         if (rx_slot='1' or tx_slot='1') and rst_slot='0' and bit_mode='1' then
            case sample_count is
               when "00000" =>
                  outwire <= '0';--generovanie "hodinoveho start impuzu"
                  
               when "00101" =>   
                  if rx_slot='1' then--primanie bitov
                     rx_register <= inwire & rx_register(7 downto 1) ;
                     bit_valid<='1';
                  elsif tx_slot='1' then
                      crc <= crc(6 downto 5) & (crcpoly xor crc(4)) & (crcpoly xor crc(3)) & crc (2 downto 0) & crcpoly ;--generovanie CRC z vysielanych bitov (pri hladani slave zariadeni)
                  end if;
                                    
               when "11111" =>--kontrola ukoncenia
                  outwire <= '1';--zakoncenie vysielania/primania
                  rx_slot <='0';
                  tx_slot <='0';
                  bit_valid <='0';
                  sample_count <=(others => '0');
                  
               when others =>
                  if tx_slot='1' and tx_register(0)='0' then--vysielanie bitu
                     outwire <= '0';                     
                  else
                     outwire <= '1';
                  end if;
                  
            end case;
            sample_count <= sample_count+1;
         end if;
--------------------------------------------------------------------------------------------------------------
      else
         clk_counter <= clk_counter+1;
      end if;
   end if;
end process;
end architecture arch;