<?php

	$type = $_GET["type"];
	$key = $_GET["key"];
	$message = $_GET["message"];
	$iv = $_GET["iv"];

	if ($type && $key && $message && $iv)
	{
		if (0 == strcmp($type,"encode"))
		{
			# 加密并输出加密字串
			$ciphertext = mcrypt_encrypt(MCRYPT_RIJNDAEL_128, $key,
                                 $message, MCRYPT_MODE_CBC, $iv);
			$encodeMessage = base64_encode($ciphertext);

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
			$decodeMessage = base64_decode($message);
			$decodeMessage = mcrypt_decrypt(MCRYPT_RIJNDAEL_128, $key,
                                 $decodeMessage, MCRYPT_MODE_CBC, $iv);
			

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
