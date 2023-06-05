let
  kareem = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKPUHvzZdQ/KKc3/5t2wfpU5U29VgCIDtfMHkR3FLt+N abdelkarimdjelalda@gmail.com";
in
{
  "secret1.age".publicKeys = [ kareem ];
}
