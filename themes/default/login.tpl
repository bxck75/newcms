
   <!-- <div>
	<?php if($this->error_msg != ''){ ?>
		<div class="error"><?php echo $this->error_msg; ?></div>	
	<?php } ?>
	
            <form method="post" action="index.php?route=login/login">
                    <table align="center">
                            <tr align="center">
                                    <td class="navbar-collapse collapse" >Email:</td>
                                    <td><input type="text" class="form-control" name="username" 
                                    value = "<?php if( isset($_COOKIE['Username']) && $_COOKIE['Username']!='') echo ($_COOKIE['Username']); ?>" required></td>
                            </tr>
                            <tr align="center">
                                    <td>Password:</td>
                                    <td><input type="password" name="password" class="form-control" value="" required></td>
                            </tr>
                            <tr  align="center">
                                    <td colspan="2"><input type="checkbox" value="0" <?php if( isset($_COOKIE['RememberMe']) && $_COOKIE['RememberMe']!='') echo 'checked'; ?> name="remember"> Remember Me</td>
                            </tr>	
                            <tr  align="center">
                                    <td colspan="2">
                                            <button type="submit" class="btn btn-default">Sign in</button>
                                    </td>
                            </tr>		
                    </table>
            </form>
        
    </div>-->
<div>

    <form method="post" action="index.php?route=login/login" class="form-signin">
      <h2 class="form-signin-heading">Please sign in</h2>
      <label for="inputEmail" class="sr-only">Email address</label>
      <input type="email" name="username" id="inputEmail" class="form-control" vlaue="<?php if( isset($_COOKIE['Username']) && $_COOKIE['Username']!='') echo ($_COOKIE['Username']); ?>" placeholder="Email address" required autofocus>
      <label for="inputPassword" class="sr-only">Password</label>
      <input type="password" name="password" id="inputPassword" value="" class="form-control" placeholder="Password" required>
      <div class="checkbox">
        <label>
          <input type="checkbox" <?php if( isset($_COOKIE['RememberMe']) && $_COOKIE['RememberMe']!='') echo 'checked'; ?>  name="remember" value="0"> Remember me
        </label>
      </div>
      <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
    </form>

</div>
