# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: akozin <akozin@student.42barcelona.com>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/02/20 11:47:01 by akozin            #+#    #+#              #
#    Updated: 2024/02/21 16:33:39 by akozin           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

SRCS = server.c \
	   client.c

OBJS = $(SRCS:.c=.o)

LIBFT = libft/
LIBFT_A = $(addprefix $(LIBFT), libft.a)

FTPRINTF = ft_printf/
FTPRINTF_A = $(addprefix $(FTPRINTF), libftprintf.a)

RM = rm -f

CC = cc
CFLAGS = -Wall -Wextra -Werror
MAKE = make

all:	server client

server:	server.o $(LIBFT_A) $(FTPRINTF_A)
	$(CC) -o $@ $< -L$(LIBFT) -lft -L$(FTPRINTF) -lftprintf

client:	client.o $(LIBFT_A) $(FTPRINTF_A)
	$(CC) -o $@ $< -L$(LIBFT) -lft -L$(FTPRINTF) -lftprintf

$(OBJS): %.o: %.c Makefile
	$(CC) $(CFLAGS) -c -o $@ $<

$(LIBFT_A):
	$(MAKE) -C $(LIBFT)

$(FTPRINTF_A):
	$(MAKE) -C $(FTPRINTF)

clean:
	$(MAKE) clean -C $(FTPRINTF)
	$(MAKE) clean -C $(LIBFT)
	$(RM) $(OBJS)

fclean:
	$(MAKE) fclean -C $(FTPRINTF)
	$(MAKE) fclean -C $(LIBFT)
	$(RM) $(OBJS)
	$(RM) server

re:		fclean all

.PHONY = all clean fclean re
