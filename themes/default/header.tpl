<body>
	<div id="header">
	<?php if(isset($_GET['token'])) : ?>
	<div class="drop">
	    <ul>
	       <li style="float:right; color: white; margin: 8px 10px;"><?php echo (isset($this->aut_group))?$this->aut_group:$this->text_userlogin; ?>:&nbsp;<?php echo $this->user['email']; ?></li>
		</ul>
		
		<ul class="drop_menu">
			<?php if($this->IsAuthorized($_GET['token'],'category', 'view')){?>
    		<li><a href="index.php?route=category/overview&token=<?php echo $_GET['token']; ?>"><?php echo $this->menu_categorys; ?></a>
			    <ul>
    				<?php if($this->IsAuthorized($_GET['token'],'category', 'add')){?>
    				<li><a href="index.php?route=category/add&token=<?php echo $_GET['token']; ?>"><?php echo $this->menu_add_category; ?></a></li>
    				<?php } ?>
			    </ul>
			</li>
			<?php } ?>
			
			<?php if($this->IsAuthorized($_GET['token'],'user', 'view')){?>
    		<li><a href="#"><?php echo $this->menu_usermanagement; ?></a>
				<ul>
		          	<?php if($this->IsAuthorized($_GET['token'],'user', 'view')){?>
    				<li><a href="index.php?route=user/overview&token=<?php echo $_GET['token']; ?>"><?php echo $this->menu_manage_users; ?></a></li>
    				<?php } ?>
			        <?php if($this->IsAuthorized($_GET['token'],'user', 'edit')){?>
    				<li><a href="index.php?route=user/group&token=<?php echo $_GET['token']; ?>"><?php echo $this->menu_manage_groups; ?></a></li>
    				<?php } ?>
    				<?php if($this->IsAuthorized($_GET['token'],'user', 'add')){?>
    				<li><a href="index.php?route=user/add&token=<?php echo $_GET['token']; ?>"><?php echo $this->menu_add_user; ?></a></li>
    				<?php } ?>
				</ul>
			</li>
    		<?php } ?>
			
			<li><a href="index.php?route=login/logout&token=<?php echo $_GET['token'] ?>"><?php echo $this->menu_logout; ?></a>
			</li>
		</ul>
	</div>
	
	<?php endif; ?>
	</div>
	<div class="clear_all">&nbsp;</div>
	<h1><?php echo $this->title; ?></h1>
	<div id="container">
