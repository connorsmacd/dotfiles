-- auto-session
-- https://github.com/rmagatti/auto-session
--
-- Eager (was `lazy = false`), so a session is restored during startup.

require('pack').add { 'rmagatti/auto-session' }

require('auto-session').setup {}
