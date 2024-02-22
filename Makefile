# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: akozin <akozin@student.42barcelona.com>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/02/20 11:47:01 by akozin            #+#    #+#              #
#    Updated: 2024/02/22 18:35:42 by akozin           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

SRCS = server.c \
	   client.c

OBJS = $(SRCS:.c=.o)
DS = $(SRCS:.c=.d)

LIBFT = libft/
LIBFT_A = $(addprefix $(LIBFT), libft.a)

FTPRINTF = ft_printf/
FTPRINTF_A = $(addprefix $(FTPRINTF), libftprintf.a)

RM = rm -f

CC = cc
CFLAGS = -Wall -Wextra -Werror
MAKE = make

all:		make_libs server client

make_libs:
	$(MAKE) -C $(LIBFT)
	$(MAKE) -C $(FTPRINTF)

server:	server.o $(LIBFT_A) $(FTPRINTF_A)
	$(CC) -o $@ $< -L$(LIBFT) -lft -L$(FTPRINTF) -lftprintf

client:	client.o $(LIBFT_A) $(FTPRINTF_A)
	$(CC) -o $@ $< -L$(LIBFT) -lft -L$(FTPRINTF) -lftprintf

$(OBJS): %.o: %.c Makefile
	$(CC) $(CFLAGS) -MMD -MP -c -o $@ $<

-include $(DS)

clean:
	$(MAKE) clean -C $(FTPRINTF)
	$(MAKE) clean -C $(LIBFT)
	$(RM) $(OBJS) $(DS)

fclean:
	$(MAKE) fclean -C $(FTPRINTF)
	$(MAKE) fclean -C $(LIBFT)
	$(RM) $(OBJS) $(DS)
	$(RM) server

re:		fclean all

.PHONY: all clean fclean re
