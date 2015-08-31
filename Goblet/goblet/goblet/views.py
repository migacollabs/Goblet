import os
import sys
import datetime
import traceback
import ConfigParser
from hashlib import sha512
from pyramid.response import Response
from pyramid.view import view_config, forbidden_view_config
from pyramid.httpexceptions import *
from pyramid.security import remember, forget, authenticated_userid
from mako.template import Template
# pyaella imports
from pyaella import *
from pyaella import dinj
from pyaella.server.api import *
from pyaella.orm.xsqlalchemy import SQLAlchemySessionFactory
from pyaella.orm.auth import get_user

from goblet.models import *

HOST, PORT = None, None
try:
    # Read host and port from a standard
    # Paste, waitress config .ini file 
    __cfg = ConfigParser.ConfigParser()
    __cfg.read(sys.argv[1])
    HOST = __cfg.get('server:main', 'host')
    PORT = __cfg.get('server:main', 'port')
except:pass # ignore

def get_session():
    return SQLAlchemySessionFactory().Session

# TODO: memoize
def get_app_config():
    return dinj.AppConfig()

def get_dinj_config(app_config):
    return dinj.DinjLexicon(parsable=app_config.FullConfigPath)

@memoize
def get_site_addr():
        sn = get_dinj_config(get_app_config()).Web.SiteName 
        return sn + ':%s'%PORT if PORT not in ['80', ''] else ''

# @view_config(
#     name='login',
#     request_method='GET',
#     context='goblet:contexts.AppRoot',
#     renderer='login.mako')
# def login_get(request):
#     args = list(request.subpath)
#     kwds = _process_subpath(args)
#     return {
#         'url': '/login',
#         'came_from': '/login',
#         'login': '',
#         'password': '',
#         'message': '',
#         'logged_in': authenticated_userid(request)
#     }

# @view_config(
#     name='login',
#     request_method='POST',
#     context='goblet:contexts.AppRoot',
#     renderer='login.mako')
# @forbidden_view_config(renderer='login.mako')
# def login_post(request):
#     login_url = request.resource_url(request.context, 'login')
#     referrer = request.url
#     if referrer == login_url:
#         referrer = '/'
#     came_from = request.params.get('came_from', referrer)
#     message = ''
#     login = ''
#     password = ''
#     if 'form.submitted' in request.params:
#         login = request.params['login']
#         password = sha512(request.params['password']+default_hashkey).hexdigest()
#         user = get_user(login)
#         if user:
#             if user.password == password:
#                 headers = remember(request, login)
#                 redirect = came_from if came_from != '/login' else '/'
#                 return HTTPFound(location=redirect, headers=headers)
#         message = 'Failed login'
#     return dict(
#         message=message,
#         url=request.application_url + '/login',
#         came_from=came_from,
#         login=login,
#         password=password,
#         logged_in=authenticated_userid(request)
#     )

# @view_config(
#     context='goblet:contexts.AppRoot',
#     name='logout')
# def logout(request):
#     headers = forget(request)
#     return HTTPFound(
#         location='/login', headers=headers)

@view_config(
    name='',
    request_method='GET',
    renderer='default.mako')
def say_hello(request):
    return {'app_name': 'Goblet'}



@view_config(
    name='',
    request_method='GET',
    context='goblet:contexts.GameObjects',
    renderer='game.objects.mako')
def get_game_objects(request):
    try:
        args = list(request.subpath)
        kwds = _process_subpath(args)

        with SQLAlchemySessionFactory() as session:

            GO = ~GameObject
            game_objects = session.query(GO).order_by(GO.name).all()

            return dict(
                status='Ok',
                game_objects=game_objects
                )

        raise HTTPUnauthorized

    except HTTPAccepted: raise
    except HTTPGone: raise
    except HTTPFound: raise
    except HTTPUnauthorized: raise
    except HTTPConflict: raise
    except:
        print traceback.format_exc()
        raise HTTPBadRequest(explanation='Invalid query parameters?')
    finally:
        try:
            session.close()
        except:
            pass



@view_config(
    name='edit',
    request_method='POST',
    context='goblet:contexts.GameObjects',
    renderer='json')
def new_game_object(request):
    try:
        args = list(request.subpath)
        kwds = _process_subpath(args, formUrlEncodedParams=request.POST)

        print 'new_game_object kwds', kwds

        with SQLAlchemySessionFactory() as session:

            go = GameObject(**kwds)
            go.save(session=session)


            return dict(
                status='Ok',
                game_object=go
                )

        raise HTTPUnauthorized

    except HTTPAccepted: raise
    except HTTPGone: raise
    except HTTPFound: raise
    except HTTPUnauthorized: raise
    except HTTPConflict: raise
    except:
        print traceback.format_exc()
        raise HTTPBadRequest(explanation='Invalid query parameters?')
    finally:
        try:
            session.close()
        except:
            pass


















