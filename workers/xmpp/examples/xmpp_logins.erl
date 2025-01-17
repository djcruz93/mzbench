[
    {make_install, [{git, "https://github.com/djcruz93/mzbench.git"},
                    {dir, "workers/xmpp"}]},

    {pool, [{size, {numvar, "users-number", 1000}},
            {worker_type, xmpp_worker},
            {worker_start, {linear, {{numvar, "user-rps", 100}, rps}}}],
        [
            {loop, [{time, {{numvar, "duration", 20}, min}},
                    {rate, {ramp, linear, {{numvar, "min-login-rpm", 10},  rpm},
                                          {{numvar, "max-login-rpm", 20},  rpm}}}], [

                % connect to xmpp.example.com:5222 server and
                % use domain.example.com as domain
                % use user_{pool_id} as nickname
                {connect, {iname, "user", {pool_id}},
                          "domain.example.com",
                          "xmpp.example.com",
                          5222},


                % send initial presence
                {initial_presence},

                % close socket and halt stream parser
                {close}
            ]}
        ]
    }
].
