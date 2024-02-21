/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   client.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: akozin <akozin@student.42barcelona.com>    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/02/21 13:59:12 by akozin            #+#    #+#             */
/*   Updated: 2024/02/21 17:04:10 by akozin           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "ft_printf/ft_printf.h"
#include "libft/libft.h"
#include <unistd.h>
#include <signal.h>

void	convert_to_bit_flow(char *msg, int servpid)
{
	char	c;
	int		i;

	while (*msg)
	{
		i = 0;
		c = *msg;
		while (i < 8)
		{
			if (c % 2)
				kill(servpid, SIGUSR2);
			else
				kill(servpid, SIGUSR1);
			c /= 2;
			i++;
			usleep(100);
		}
		msg++;
	}
	i = 0;
}

int	main(int argc, char **argv)
{
	int	servpid;

	if (argc != 3)
	{
		ft_putstr_fd("Usage: ", 2);
		ft_putstr_fd(argv[0], 2);
		ft_putstr_fd(" <server PID> <msg>\n", 2);
		return (1);
	}
	servpid = ft_atoi(argv[1]);
	if (servpid <= 0)
	{
		ft_putstr_fd("Incorrectly entered PID\n", 2);
		return (1);
	}
	ft_printf("Server PID entered: %d\n", servpid);
	ft_printf("If you see nothing, maybe check PID & retry.\n");
	ft_printf("By default, user signals terminate the process. (man signal)\n");
	ft_printf("Be careful with your PID!\n");
	convert_to_bit_flow(argv[2], servpid);
	return (0);
}
