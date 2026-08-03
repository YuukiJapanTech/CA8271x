set		MISS_TO_CPU			1
set		TCP_CTRL_TO_CPU			1
set		AGING_TIME			20

set nat_config [ ca_nat_config_create ]
ca_nat_config_set_miss_to_cpu			$nat_config			$MISS_TO_CPU
ca_nat_config_set_tcp_ctrl_to_cpu		$nat_config			$TCP_CTRL_TO_CPU
ca_nat_config_set_aging_time			$nat_config			$AGING_TIME

ca_nat_config_set 0 $nat_config


