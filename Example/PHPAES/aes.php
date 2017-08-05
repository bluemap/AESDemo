<?php
	require 'GibberishAES.php'; // class

	$type = $_GET["type"];
	$secseed = $_GET["seed"];
	$message = $_GET["message"];

	if ($type && $secseed && $message)
	{
		GibberishAES::size(256);
		if (0 == strcmp($type,"encode"))
		{
			# 加密并输出加密字串
			$encodeMessage = GibberishAES::enc($message, $secseed);

			if ($encodeMessage) 
			{
				echo $encodeMessage;
			}
			else
			{
				echo "php encode err";
			}
		}
		else if (0 == strcmp($type,"decode")) 
		{
			# 解密并输出解密字符串
			$decodeMessage = GibberishAES::dec($message, $secseed);
			if ($decodeMessage) 
			{
				echo $decodeMessage;
			}
			else
			{
				echo "php decode err";
			}
		}

	}
	else
	{
		echo "no type or seed or message param";
	}
	?>
