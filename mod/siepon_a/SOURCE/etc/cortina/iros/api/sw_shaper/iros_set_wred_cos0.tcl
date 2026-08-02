
##DP value (CoS 0)
ca_queue_wred_profile_set_marked_dp $profile 63 0
ca_queue_wred_profile_set_marked_dp $profile 63 1
ca_queue_wred_profile_set_marked_dp $profile 63 2
ca_queue_wred_profile_set_marked_dp $profile 63 3
ca_queue_wred_profile_set_marked_dp $profile 63 4
ca_queue_wred_profile_set_marked_dp $profile 63 5
ca_queue_wred_profile_set_marked_dp $profile 57 6
ca_queue_wred_profile_set_marked_dp $profile 52 7
ca_queue_wred_profile_set_marked_dp $profile 46 8
ca_queue_wred_profile_set_marked_dp $profile 40 9
ca_queue_wred_profile_set_marked_dp $profile 34 10
ca_queue_wred_profile_set_marked_dp $profile 29 11
ca_queue_wred_profile_set_marked_dp $profile 23 12
ca_queue_wred_profile_set_marked_dp $profile 17 13
ca_queue_wred_profile_set_marked_dp $profile 11 14
ca_queue_wred_profile_set_marked_dp $profile 6  15

ca_queue_wred_profile_set_unmarked_dp $profile 63 0
ca_queue_wred_profile_set_unmarked_dp $profile 63 1
ca_queue_wred_profile_set_unmarked_dp $profile 63 2
ca_queue_wred_profile_set_unmarked_dp $profile 63 3
ca_queue_wred_profile_set_unmarked_dp $profile 63 4
ca_queue_wred_profile_set_unmarked_dp $profile 57 5
ca_queue_wred_profile_set_unmarked_dp $profile 52 6
ca_queue_wred_profile_set_unmarked_dp $profile 46 7
ca_queue_wred_profile_set_unmarked_dp $profile 40 8
ca_queue_wred_profile_set_unmarked_dp $profile 34 9
ca_queue_wred_profile_set_unmarked_dp $profile 29 10
ca_queue_wred_profile_set_unmarked_dp $profile 23 11
ca_queue_wred_profile_set_unmarked_dp $profile 17 12
ca_queue_wred_profile_set_unmarked_dp $profile 11 13
ca_queue_wred_profile_set_unmarked_dp $profile 6  14
ca_queue_wred_profile_set_unmarked_dp $profile 0  15

ca_queue_wred_set 0 $port_id 0 $profile
