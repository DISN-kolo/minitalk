/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   server.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: akozin <akozin@student.42barcelona.com>    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/02/20 11:40:57 by akozin            #+#    #+#             */
/*   Updated: 2024/02/21 16:51:17 by akozin           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "ft_printf/ft_printf.h"
#include "libft/libft.h"
#include <unistd.h>
#include <signal.h>

int	g_i;
// i is the power of 2; that is to say, where we are bit-wise in the current
// character
//     i: 7 6 5 4 3 2 1 0
// c = 0b 0 1 0 1 0 1 0 1

int	powtwo(int i)
{
	int	res;

	res = 1;
	if (!i)
		return (1);
	while (i--)
		res *= 2;
	return (res);
}

void	handle(int sig)
{
	static char	c;
	int			bit;

	if (g_i == 8)
	{
		g_i = 0;
		c = 0;
	}
	if (g_i < 8)
	{
		if (sig == SIGUSR1)
			bit = 0;
		else
			bit = 1;
		c += powtwo(g_i) * bit;
		g_i++;
		if (g_i == 8)
			ft_putchar_fd(c, 1);
	}
}

int	main(void)
{
	struct sigaction	s_sa;
	int					pid;

	g_i = 8;
	s_sa.sa_handler = &handle;
	s_sa.sa_flags = SA_RESTART;
	sigaction(SIGUSR1, &s_sa, NULL);
	sigaction(SIGUSR2, &s_sa, NULL);
	pid = getpid();
	ft_printf("Server PID: %d\n", pid);
	while (1)
		pause();
	return (0);
}
