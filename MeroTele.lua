#!/usr/bin/env lua5.2
local Merotele_function, function_core, update_functions, Merotele_timer = {}, {}, {}, {}
local Merotele = {
  get_update = true,
  logo = [[

]],

colors_key = {
  reset =      0,
  bright     = 1,
  dim        = 2,
  underline  = 4,
  blink      = 5,
  reverse    = 7,
  hidden     = 8,
  black     = 30,
  red       = 31,
  green     = 32,
  yellow    = 33,
  blue      = 34,
  magenta   = 35,
  cyan      = 36,
  white     = 37,
  blackbg   = 40,
  redbg     = 41,
  greenbg   = 42,
  yellowbg  = 43,
  bluebg    = 44,
  magentabg = 45,
  cyanbg    = 46,
  whitebg   = 47
},
  config = {
  }
}
--local MeroTele =  require('Merotele') 
local MeroTele =  require('MeroLua') 
local client = MeroTele()
----------------------------------------------- Merotele core function
function function_core._CALL_(update)
  if update and type(update) == 'table' then
    for i = 0 , #update_functions do
      if not update_functions[i].filters then
        send_update = true
        update_message = update
      elseif update.Merotele and update_functions[i].filters and Merotele_function.in_array(update_functions[i].filters,  update.Merotele) then
        send_update = true
        update_message = update
      else
        send_update = false
      end
      if update_message and send_update and type(update_message) == 'table' then
        xpcall(update_functions[i].def, function_core.print_error, update_message)
      end
      update_message = nil
      send_update = nil
    end
  end
end
function Merotele_function.vardump(input)
  local function vardump(value)
     if type(value) == 'table' then
        local dump = '{\n'
        for key,v in pairs(value) do
           if type(key) == 'number' then
             key = '['..key..']'
           elseif type(key) == 'string' and key:match('@') then
             key = '["'..key..'"]'
           end
           if type(v) == 'string' then
             v = "'" .. v .. "'"
           end
           dump = dump .. key .. ' = ' .. vardump(v) .. ',\n'
        end
        return dump .. '}'
     else
        return tostring(value)
     end
   end
  print(Merotele_function.colors('%{underline} Method information : %{reset}\n\n%{yellow}'..vardump(input)))
  return vardump(input)
end
function function_core.change_table(input, send)
  if send then
    changes ={
      Merotele = string.reverse('epyt@')
    }
    rems = {
    }
  else
    changes = {
      _ = string.reverse('eletoreM'),
    }
    rems = {
      string.reverse('epyt@')
    }
  end
  if type(input) == 'table' then
    local res = {}
    for key,value in pairs(input) do
      for k, rem in pairs(rems) do
        if key == rem then
          value = nil
        end
      end
      local key = changes[key] or key
      if type(value) ~= 'table' then
        res[key] = value
      else
        res[key] = function_core.change_table(value, send)
      end
    end
    return res
  else
 
    return input
  end
end
function function_core.run_table(input)
  local to_original = function_core.change_table(input, true)
  local result = client:execute(to_original)
  if type(result) ~= 'table' then
    return nil
  else
    return function_core.change_table(result)
  end
end
function function_core.print_error(err)
  print(Merotele_function.colors('%{blue}\27[5m There is an error in the file, please correct it %{reset}\n\n%{red}'.. err))
end
function function_core.send_tdlib(input)
  local to_original = function_core.change_table(input, true)
  client:send(to_original)
end

function_core.send_tdlib{
  Merotele = 'getAuthorizationState'
}
MeroTele.setLogLevel(3)
MeroTele.setLogPath('/usr/lib/x86_64-linux-gnu/lua/5.2/.Merotele.log')
-----------------------------------------------Merotele_function
function Merotele_function.len(input)
  if type(input) == 'table' then
    size = 0
    for key,value in pairs(input) do
      size = size + 1
    end
    return size
  else
    size = tostring(input)
    return #size
  end
end
function Merotele_function.match(...)
  local val = {}
  for no,v in ipairs({...}) do
    val[v] = true
  end
  return val
end
function Merotele_function.secToClock(seconds)
  local seconds = tonumber(seconds)
  if seconds <= 0 then
    return {hours=00,mins=00,secs=00}
  else
    local hours = string.format("%02.f", math.floor(seconds / 3600));
    local mins = string.format("%02.f", math.floor(seconds / 60 - ( hours*60 ) ));
    local secs = string.format("%02.f", math.floor(seconds - hours * 3600 - mins * 60));
    return {hours=hours,mins=mins,secs=secs}
  end
end
function Merotele_function.number_format(num)
  local out = tonumber(num)
  while true do
    out,i= string.gsub(out,'^(-?%d+)(%d%d%d)', '%1,%2')
    if (i==0) then
      break
    end
  end
  return out
end
function Merotele_function.base64_encode(str)
	local Base ='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
	return ((str:gsub('.', function(x)
			local r,Base='',x:byte()
			for i=8,1,-1 do r=r..(Base%2^i-Base%2^(i-1)>0 and '1' or '0') end
			return r;
	end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
			if (#x < 6) then return '' end
			local c=0
			for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
			return Base:sub(c+1,c+1)
	end)..({ '', '==', '=' })[#str%3+1])
end
function Merotele_function.base64_decode(str)
	local Base ='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
  str = string.gsub(str, '[^'..Base..'=]', '')
  return (str:gsub('.', function(x)
    if (x == '=') then
      return ''
    end
    local r,f='',(Base:find(x)-1)
    for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
    return r;
  end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
    if (#x ~= 8) then
      return ''
    end
    local c=0
    for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
    return string.char(c)
  end))
end
function Merotele_function.exists(file)
   local ok, err, code = os.rename(file, file)
   if not ok then
      if code == 13 then
         return true
      end
   end
   return ok, err
end
function Merotele_function.in_array(table, value)
  for k,v in pairs(table) do
    if value == v then
      return true
    end
  end
  return false
end
function Merotele_function.colors(buffer)
  for keys in buffer:gmatch('%%{(.-)}') do
    buffer = string.gsub(buffer,'%%{'..keys..'}', '\27['..Merotele.colors_key[keys]..'m')
  end
  return buffer .. '\27[0m'
end
function Merotele_function.add_events(def,filters)
  if type(def) ~= 'function' then
    function_core.print_error('the add_events def must be a function !')
    return {
      Merotele = false,
    }
    elseif type(filters) ~= 'table' then
      function_core.print_error('the add_events filters must be a table !')
      return {
        Merotele = false,
      }
    else
      local function_id = #update_functions + 1
      update_functions[function_id] = {}
      update_functions[function_id].def = def
      update_functions[function_id].filters = filters
      return {
        Merotele = true,
      }
  end
end


function Merotele_function.set_timer(seconds, def, argv)
  if type(seconds) ~= 'number' then
    return {
      Merotele = false,
      message = 'set_timer(int seconds, funtion def, table)'
    }
  elseif type(def) ~= 'function' then
    return {
      Merotele = false,
      message = 'set_timer(int seconds, funtion def, table)'
    }
  end
  Merotele_timer[#Merotele_timer + 1] = {
    def = def,
    argv = argv,
    run_in = os.time() + seconds
  }
  return {
    Merotele = true,
    run_in = os.time() + seconds,
    timer_id = #Merotele_timer
  }
end
function Merotele_function.get_timer(timer_id)
  local timer_data = Merotele_timer[timer_id]
  if timer_data then
    return {
      Merotele = true,
      run_in = timer_data.run_in,
      argv = timer_data.argv
    }
  else
    return {
      Merotele = false,
    }
  end
end
function Merotele_function.cancel_timer(timer_id)
  if Merotele_timer[timer_id] then
    table.remove(Merotele_timer,timer_id)
    return {
      Merotele = true
    }
  else
    return {
      Merotele = false
    }
  end
end

function Merotele_function.replyMarkup(input)
  if type(input.type) ~= 'string' then
    return nil
  end
  local _type = string.lower(input.type)
  if _type == 'inline' then
    local result = {
      Merotele = 'replyMarkupInlineKeyboard',
      rows = {
      }
    }
    for _, rows in pairs(input.data) do
      local new_id = #result.rows + 1
      result.rows[new_id] = {}
      for key, value in pairs(rows) do
        local rows_new_id = #result.rows[new_id] + 1
        if value.url and value.text then
          result.rows[new_id][rows_new_id] = {
            Merotele = 'inlineKeyboardButton',
            text = value.text,
            type = {
              Merotele = 'inlineKeyboardButtonTypeUrl',
              url = value.url
            }
          }
        elseif value.data and value.text then
            result.rows[new_id][rows_new_id] = {
              Merotele = 'inlineKeyboardButton',
              text = value.text,
              type = {
                data = Merotele_function.base64_encode(value.data), -- Base64 only
                Merotele = 'inlineKeyboardButtonTypeCallback',
              }
            }
          elseif value.forward_text and value.id and value.url and value.text then
            result.rows[new_id][rows_new_id] = {
              Merotele = 'inlineKeyboardButton',
              text = value.text,
              type = {
                id = value.id,
                url = value.url,
                forward_text = value.forward_text,
                Merotele = 'inlineKeyboardButtonTypeLoginUrl',
              }
            }
          elseif value.query and value.text then
            result.rows[new_id][rows_new_id] = {
              Merotele = 'inlineKeyboardButton',
              text = value.text,
              type = {
                query = value.query,
                Merotele = 'inlineKeyboardButtonTypeSwitchInline',
              }
            }
        end
      end
    end
    return result
  elseif _type == 'keyboard' then
    local result = {
      Merotele = 'replyMarkupShowKeyboard',
      resize_keyboard = input.resize,
      one_time = input.one_time,
      is_personal = input.is_personal,
      rows = {
      }
    }
    for _, rows in pairs(input.data) do
      local new_id = #result.rows + 1
      result.rows[new_id] = {}
      for key, value in pairs(rows) do
        local rows_new_id = #result.rows[new_id] + 1
        if type(value.type) == 'string' then
          value.type = string.lower(value.type)
          if value.type == 'requestlocation' and value.text then
            result.rows[new_id][rows_new_id] = {
              type = {
                Merotele = 'keyboardButtonTypeRequestLocation'
              },
              Merotele = 'keyboardButton',
              text = value.text
            }
          elseif value.type == 'requestphone' and value.text then
            result.rows[new_id][rows_new_id] = {
              type = {
                Merotele = 'keyboardButtonTypeRequestPhoneNumber'
              },
              Merotele = 'keyboardButton',
              text = value.text
            }
          elseif value.type == 'requestpoll' and value.text then
            result.rows[new_id][rows_new_id] = {
              type = {
                Merotele = 'keyboardButtonTypeRequestPoll',
                force_regular = value.force_regular,
                force_quiz = value.force_quiz
              },
              Merotele = 'keyboardButton',
              text = value.text
            }
          elseif value.type == 'text' and value.text then
            result.rows[new_id][rows_new_id] = {
              type = {
                Merotele = 'keyboardButtonTypeText'
              },
              Merotele = 'keyboardButton',
              text = value.text
            }
          end
        end
      end
    end
    return result
  elseif _type == 'forcereply' then
    return {
      Merotele = 'replyMarkupForceReply',
      is_personal = input.is_personal
    }
  elseif _type == 'remove' then
    return {
      Merotele = 'replyMarkupRemoveKeyboard',
      is_personal = input.is_personal
    }
  end
end
function Merotele_function.addProxy(proxy_type, server, port, username, password_secret, http_only)
  if type(proxy_type) ~= 'string' then
    return {
    Merotele = false
    }
  end
  local proxy_type = string.lower(proxy_type)
  if proxy_type == 'mtproto' then
    _type_ = {
      Merotele = 'proxyTypeMtproto',
      secret = password_secret
    }
  elseif proxy_Type == 'socks5' then
    _type_ = {
      Merotele = 'proxyTypeSocks5',
      username = username,
      password = password_secret
    }
  elseif proxy_Type == 'http' then
    _type_ = {
      Merotele = 'proxyTypeHttp',
      username = username,
      password = password_secret,
      http_only = http_only
    }
  else
    return {
      Merotele = false
    }
  end
  return function_core.run_table{
    Merotele = 'addProxy',
    server = server,
    port = port,
    type = _type_
  }
end
function Merotele_function.enableProxy(proxy_id)
  return function_core.run_table{
   Merotele = 'enableProxy',
    proxy_id = proxy_id
  }
end
function Merotele_function.pingProxy(proxy_id)
  return function_core.run_table{
   Merotele = 'pingProxy',
    proxy_id = proxy_id
  }
end
function Merotele_function.disableProxy(proxy_id)
  return function_core.run_table{
   Merotele = 'disableProxy',
    proxy_id = proxy_id
  }
end
function Merotele_function.getProxies()
  return function_core.run_table{
    Merotele = 'getProxies'
  }
end
function Merotele_function.getChatId(chat_id)
  local chat_id = tostring(chat_id)
  if chat_id:match('^-100') then
    return {
      id = string.sub(chat_id, 5),
      type = 'supergroup'
    }
  else
    local basicgroup_id = string.sub(chat_id, 2)
    return {
      id = string.sub(chat_id, 2),
      type = 'basicgroup'
    }
  end
end
function Merotele_function.getInputFile(file, conversion_str, expected_size)
  local str = tostring(file)
  if (conversion_str and expectedsize) then
    return {
      Merotele = 'inputFileGenerated',
      original_path = tostring(file),
      conversion = tostring(conversion_str),
      expected_size = expected_size
    }
  else
    if str:match('/') then
      return {
        Merotele = 'inputFileLocal',
        path = file
      }
    elseif str:match('^%d+$') then
      return {
        Merotele = 'inputFileId',
        id = file
      }
    else
      return {
        Merotele = 'inputFileRemote',
        id = file
      }
    end
  end
end
function Merotele_function.getParseMode(parse_mode)
  if parse_mode then
    local mode = parse_mode:lower()
    if mode == 'markdown' or mode == 'md' then
      return {
        Merotele = 'textParseModeMarkdown'
      }
    elseif mode == 'html' or mode == 'lg' then
      return {
        Merotele = 'textParseModeHTML'
      }
    end
  end
end
function Merotele_function.parseTextEntities(text, parse_mode)
  if type(parse_mode) == 'string' and string.lower(parse_mode) == 'lg' then
    for txt in text:gmatch('%%{(.-)}') do
      local _text, text_type = txt:match('(.*),(.*)')
      local txt = string.gsub(txt,'+','++')
      local text_type = string.gsub(text_type,' ','')
      if type(_text) == 'string' and type(text_type) == 'string' then
        for key, value in pairs({['<'] = '&lt;',['>'] = '&gt;'}) do
          _text = string.gsub(_text, key, value)
        end
        if (string.lower(text_type) == 'b' or string.lower(text_type) == 'i' or string.lower(text_type) == 'c') then
          local text_type = string.lower(text_type)
          local text_type = text_type == 'c' and 'code' or text_type
          text = string.gsub(text,'%%{'..txt..'}','<'..text_type..'>'.._text..'</'..text_type..'>')
        else
          if type(tonumber(text_type)) == 'number' then
            link = 'tg://user?id='..text_type
          else
            link = text_type
          end
          text = string.gsub(text, '%%{'..txt..'}', '<a href="'..link..'">'.._text..'</a>')
        end
      end
    end
  end
  return function_core.run_table{
    Merotele = 'parseTextEntities',
    text = tostring(text),
    parse_mode = Merotele_function.getParseMode(parse_mode)
  }
end
function Merotele_function.vectorize(table)
  if type(table) == 'table' then
    return table
  else
    return {
      table
    }
  end
end
function Merotele_function.setLimit(limit, num)
  local limit = tonumber(limit)
  local number = tonumber(num or limit)
  return (number >= limit) and limit or number
end
function Merotele_function.sendMessage(chat_id, reply_to_message_id, input_message_content, parse_mode, disable_notification, from_background, reply_markup)
  local Merotele_body, message = {
    Merotele = 'sendMessage',
    chat_id = chat_id,
    reply_to_message_id = reply_to_message_id or 0,
    disable_notification = disable_notification or 0,
    from_background = from_background or 1,
    reply_markup = reply_markup,
    input_message_content = input_message_content
  }, {}
  if input_message_content.text then
    text = input_message_content.text.text
  elseif input_message_content.caption then
    text = input_message_content.caption.text
  end
  if text then
    if parse_mode then
      local result = Merotele_function.parseTextEntities(text, parse_mode)
      if Merotele_body.input_message_content.text then
        Merotele_body.input_message_content.text = result
      else
        Merotele_body.input_message_content.caption = result
      end
      return function_core.run_table(Merotele_body)
    else
      while #text > 4096 do
        text = string.sub(text, 4096, #text)
        message[#message + 1] = text
      end
      message[#message + 1] = text
      for i = 1, #message do
        if input_message_content.text and input_message_content.text.text then
          Merotele_body.input_message_content.text.text = message[i]
        elseif input_message_content.caption and input_message_content.caption.text then
          Merotele_body.input_message_content.caption.text = message[i]
        end
        return function_core.run_table(Merotele_body)
      end
    end
  else
    return function_core.run_table(Merotele_body)
  end
end
function Merotele_function.logOut()
  return function_core.run_table{
    Merotele = 'logOut'
  }
end
function Merotele_function.getPasswordState()
  return function_core.run_table{
    Merotele = 'getPasswordState'
  }
end
function Merotele_function.setPassword(old_password, new_password, new_hint, set_recovery_email_address, new_recovery_email_address)
  return function_core.run_table{
    old_password = tostring(old_password),
    new_password = tostring(new_password),
    new_hint = tostring(new_hint),
    set_recovery_email_address = set_recovery_email_address,
    new_recovery_email_address = tostring(new_recovery_email_address)
  }
end
function Merotele_function.getRecoveryEmailAddress(password)
  return function_core.run_table{
    Merotele = 'getRecoveryEmailAddress',
    password = tostring(password)
  }
end
function Merotele_function.setRecoveryEmailAddress(password, new_recovery_email_address)
  return function_core.run_table{
    Merotele = 'setRecoveryEmailAddress',
    password = tostring(password),
    new_recovery_email_address = tostring(new_recovery_email_address)
  }
end
function Merotele_function.requestPasswordRecovery()
  return function_core.run_table{
    Merotele = 'requestPasswordRecovery'
  }
end
function Merotele_function.recoverPassword(recovery_code)
  return function_core.run_table{
    Merotele = 'recoverPassword',
    recovery_code = tostring(recovery_code)
  }
end
function Merotele_function.createTemporaryPassword(password, valid_for)
  local valid_for = valid_for > 86400 and 86400 or valid_for
  return function_core.run_table{
    Merotele = 'createTemporaryPassword',
    password = tostring(password),
    valid_for = valid_for
  }
end
function Merotele_function.getTemporaryPasswordState()
  return function_core.run_table{
    Merotele = 'getTemporaryPasswordState'
  }
end
function Merotele_function.getMe()
  return function_core.run_table{
    Merotele = 'getMe'
  }
end
function Merotele_function.getUser(user_id)
  return function_core.run_table{
    Merotele = 'getUser',
    user_id = user_id
  }
end
function Merotele_function.getUserFullInfo(user_id)
  return function_core.run_table{
    Merotele = 'getUserFullInfo',
    user_id = user_id
  }
end
function Merotele_function.getBasicGroup(basic_group_id)
  return function_core.run_table{
    Merotele = 'getBasicGroup',
    basic_group_id = Merotele_function.getChatId(basic_group_id).id
  }
end
function Merotele_function.getBasicGroupFullInfo(basic_group_id)
  return function_core.run_table{
    Merotele = 'getBasicGroupFullInfo',
    basic_group_id = Merotele_function.getChatId(basic_group_id).id
  }
end
function Merotele_function.getSupergroup(supergroup_id)
  return function_core.run_table{
    Merotele = 'getSupergroup',
    supergroup_id = Merotele_function.getChatId(supergroup_id).id
  }
end
function Merotele_function.getSupergroupFullInfo(supergroup_id)
  return function_core.run_table{
    Merotele = 'getSupergroupFullInfo',
    supergroup_id = Merotele_function.getChatId(supergroup_id).id
  }
end
function Merotele_function.getSecretChat(secret_chat_id)
  return function_core.run_table{
    Merotele = 'getSecretChat',
    secret_chat_id = secret_chat_id
  }
end
function Merotele_function.getChat(chat_id)
  return function_core.run_table{
    Merotele = 'getChat',
    chat_id = chat_id
  }
end
function Merotele_function.getMessage(chat_id, message_id)
  return function_core.run_table{
    Merotele = 'getMessage',
    chat_id = chat_id,
    message_id = message_id
  }
end
function Merotele_function.getRepliedMessage(chat_id, message_id)
  return function_core.run_table{
    Merotele = 'getRepliedMessage',
    chat_id = chat_id,
    message_id = message_id
  }
end
function Merotele_function.getChatPinnedMessage(chat_id)
  return function_core.run_table{
    Merotele = 'getChatPinnedMessage',
    chat_id = chat_id
  }
end
function Merotele_function.unpinAllChatMessages(chat_id)
  return function_core.run_table{
    Merotele = 'unpinAllChatMessages',
    chat_id = chat_id
  }
end
function Merotele_function.getMessages(chat_id, message_ids)
  return function_core.run_table{
    Merotele = 'getMessages',
    chat_id = chat_id,
    message_ids = Merotele_function.vectorize(message_ids)
  }
end
function Merotele_function.getFile(file_id)
  return function_core.run_table{
    Merotele = 'getFile',
    file_id = file_id
  }
end
function Merotele_function.getRemoteFile(remote_file_id, file_type)
  return function_core.run_table{
    Merotele = 'getRemoteFile',
    remote_file_id = tostring(remote_file_id),
    file_type = {
      Merotele = 'fileType' .. file_type or 'Unknown'
    }
  }
end
function Merotele_function.getChats(chat_list, offset_order, offset_chat_id, limit)
  local limit = limit or 20
  local offset_order = offset_order or '9223372036854775807'
  local offset_chat_id = offset_chat_id or 0
  local filter = (string.lower(tostring(chat_list)) == 'archive') and 'chatListArchive' or 'chatListMain'
  return function_core.run_table{
    Merotele = 'getChats',
    offset_order = offset_order,
    offset_chat_id = offset_chat_id,
    limit = Merotele_function.setLimit(100, limit),
    chat_list = {
      Merotele = filter
    }
  }
end
function Merotele_function.searchPublicChat(username)
  return function_core.run_table{
    Merotele = 'searchPublicChat',
    username = tostring(username)
  }
end
function Merotele_function.searchPublicChats(query)
  return function_core.run_table{
    Merotele = 'searchPublicChats',
    query = tostring(query)
  }
end
function Merotele_function.searchChats(query, limit)
  return function_core.run_table{
    Merotele = 'searchChats',
    query = tostring(query),
    limit = limit
  }
end
function Merotele_function.checkChatUsername(chat_id, username)
  return function_core.run_table{
    Merotele = 'checkChatUsername',
    chat_id = chat_id,
    username = tostring(username)
  }
end
function Merotele_function.searchChatsOnServer(query, limit)
  return function_core.run_table{
    Merotele = 'searchChatsOnServer',
    query = tostring(query),
    limit = limit
  }
end
function Merotele_function.clearRecentlyFoundChats()
  return function_core.run_table{
    Merotele = 'clearRecentlyFoundChats'
  }
end
function Merotele_function.getTopChats(category, limit)
  return function_core.run_table{
    Merotele = 'getTopChats',
    category = {
      Merotele = 'topChatCategory' .. category
    },
    limit = Merotele_function.setLimit(30, limit)
  }
end
function Merotele_function.removeTopChat(category, chat_id)
  return function_core.run_table{
    Merotele = 'removeTopChat',
    category = {
      Merotele = 'topChatCategory' .. category
    },
    chat_id = chat_id
  }
end
function Merotele_function.addRecentlyFoundChat(chat_id)
  return function_core.run_table{
    Merotele = 'addRecentlyFoundChat',
    chat_id = chat_id
  }
end
function Merotele_function.getCreatedPublicChats()
  return function_core.run_table{
    Merotele = 'getCreatedPublicChats'
  }
end
function Merotele_function.removeRecentlyFoundChat(chat_id)
  return function_core.run_table{
    Merotele = 'removeRecentlyFoundChat',
    chat_id = chat_id
  }
end
function Merotele_function.getChatHistory(chat_id, from_message_id, offset, limit, only_local)
  return function_core.run_table{
    Merotele = 'getChatHistory',
    chat_id = chat_id,
    from_message_id = from_message_id,
    offset = offset,
    limit = Merotele_function.setLimit(100, limit),
    only_local = only_local
  }
end
function Merotele_function.getGroupsInCommon(user_id, offset_chat_id, limit)
  return function_core.run_table{
    Merotele = 'getGroupsInCommon',
    user_id = user_id,
    offset_chat_id = offset_chat_id or 0,
    limit = Merotele_function.setLimit(100, limit)
  }
end
function Merotele_function.searchMessages(query, offset_date, offset_chat_id, offset_message_id, limit)
  return function_core.run_table{
    Merotele = 'searchMessages',
    query = tostring(query),
    offset_date = offset_date or 0,
    offset_chat_id = offset_chat_id or 0,
    offset_message_id = offset_message_id or 0,
    limit = Merotele_function.setLimit(100, limit)
  }
end
function Merotele_function.searchChatMessages(chat_id, query, filter, sender_user_id, from_message_id, offset, limit)
  return function_core.run_table{
    Merotele = 'searchChatMessages',
    chat_id = chat_id,
    query = tostring(query),
    sender_user_id = sender_user_id or 0,
    from_message_id = from_message_id or 0,
    offset = offset or 0,
    limit = Merotele_function.setLimit(100, limit),
    filter = {
      Merotele = 'searchMessagesFilter' .. filter
    }
  }
end
function Merotele_function.searchSecretMessages(chat_id, query, from_search_id, limit, filter)
  local filter = filter or 'Empty'
  return function_core.run_table{
    Merotele = 'searchSecretMessages',
    chat_id = chat_id or 0,
    query = tostring(query),
    from_search_id = from_search_id or 0,
    limit = Merotele_function.setLimit(100, limit),
    filter = {
      Merotele = 'searchMessagesFilter' .. filter
    }
  }
end
function Merotele_function.deleteChatHistory(chat_id, remove_from_chat_list)
  return function_core.run_table{
    Merotele = 'deleteChatHistory',
    chat_id = chat_id,
    remove_from_chat_list = remove_from_chat_list
  }
end
function Merotele_function.searchCallMessages(from_message_id, limit, only_missed)
  return function_core.run_table{
    Merotele = 'searchCallMessages',
    from_message_id = from_message_id or 0,
    limit = Merotele_function.setLimit(100, limit),
    only_missed = only_missed
  }
end
function Merotele_function.getChatMessageByDate(chat_id, date)
  return function_core.run_table{
    Merotele = 'getChatMessageByDate',
    chat_id = chat_id,
    date = date
  }
end
function Merotele_function.getPublicMessageLink(chat_id, message_id, for_album)
  return function_core.run_table{
    Merotele = 'getPublicMessageLink',
    chat_id = chat_id,
    message_id = message_id,
    for_album = for_album
  }
end
function Merotele_function.sendMessageAlbum(chat_id, reply_to_message_id, input_message_contents, disable_notification, from_background)
  return function_core.run_table{
    Merotele = 'sendMessageAlbum',
    chat_id = chat_id,
    reply_to_message_id = reply_to_message_id or 0,
    disable_notification = disable_notification,
    from_background = from_background,
    input_message_contents = Merotele_function.vectorize(input_message_contents)
  }
end
function Merotele_function.sendBotStartMessage(bot_user_id, chat_id, parameter)
  return function_core.run_table{
    Merotele = 'sendBotStartMessage',
    bot_user_id = bot_user_id,
    chat_id = chat_id,
    parameter = tostring(parameter)
  }
end
function Merotele_function.sendInlineQueryResultMessage(chat_id, reply_to_message_id, disable_notification, from_background, query_id, result_id)
  return function_core.run_table{
    Merotele = 'sendInlineQueryResultMessage',
    chat_id = chat_id,
    reply_to_message_id = reply_to_message_id,
    disable_notification = disable_notification,
    from_background = from_background,
    query_id = query_id,
    result_id = tostring(result_id)
  }
end
function Merotele_function.forwardMessages(chat_id, from_chat_id, message_ids, disable_notification, from_background, as_album, send_copy, remove_caption)
  return function_core.run_table{
    Merotele = 'forwardMessages',
    chat_id = chat_id,
    from_chat_id = from_chat_id,
    message_ids = Merotele_function.vectorize(message_ids),
    disable_notification = disable_notification,
    from_background = from_background,
    as_album = as_album,
    send_copy = send_copy,
    remove_caption = remove_caption
  }
end
function Merotele_function.sendChatSetTtlMessage(chat_id, ttl)
  return function_core.run_table{
    Merotele = 'sendChatSetTtlMessage',
    chat_id = chat_id,
    ttl = ttl
  }
end
function Merotele_function.sendChatScreenshotTakenNotification(chat_id)
  return function_core.run_table{
    Merotele = 'sendChatScreenshotTakenNotification',
    chat_id = chat_id
  }
end
function Merotele_function.deleteMessages(chat_id, message_ids, revoke)
  return function_core.run_table{
    Merotele = 'deleteMessages',
    chat_id = chat_id,
    message_ids = Merotele_function.vectorize(message_ids),
    revoke = revoke
  }
end
function Merotele_function.deleteChatMessagesFromUser(chat_id, user_id)
  return function_core.run_table{
    Merotele = 'deleteChatMessagesFromUser',
    chat_id = chat_id,
    user_id = user_id
  }
end
function Merotele_function.editMessageText(chat_id, message_id, text, parse_mode, disable_web_page_preview, clear_draft, reply_markup)
  local Merotele_body = {
    Merotele = 'editMessageText',
    chat_id = chat_id,
    message_id = message_id,
    reply_markup = reply_markup,
    input_message_content = {
      Merotele = 'inputMessageText',
      disable_web_page_preview = disable_web_page_preview,
      text = {
        text = text
      },
      clear_draft = clear_draft
    }
  }
  if parse_mode then
    Merotele_body.input_message_content.text = Merotele_function.parseTextEntities(text, parse_mode)
  end
  return function_core.run_table(Merotele_body)
end
function Merotele_function.editMessageCaption(chat_id, message_id, caption, parse_mode, reply_markup)
  local Merotele_body = {
    Merotele = 'editMessageCaption',
    chat_id = chat_id,
    message_id = message_id,
    reply_markup = reply_markup,
    caption = caption
  }
  if parse_mode then
      Merotele_body.caption = Merotele_function.parseTextEntities(text,parse_mode)
  end
  return function_core.run_table(Merotele_body)
end
function Merotele_function.getTextEntities(text)
  return function_core.run_table{
    Merotele = 'getTextEntities',
    text = tostring(text)
  }
end
function Merotele_function.getFileMimeType(file_name)
  return function_core.run_table{
    Merotele = 'getFileMimeType',
    file_name = tostring(file_name)
  }
end
function Merotele_function.getFileExtension(mime_type)
  return function_core.run_table{
    Merotele = 'getFileExtension',
    mime_type = tostring(mime_type)
  }
end
function Merotele_function.getInlineQueryResults(bot_user_id, chat_id, latitude, longitude, query, offset)
  return function_core.run_table{
    Merotele = 'getInlineQueryResults',
    bot_user_id = bot_user_id,
    chat_id = chat_id,
    user_location = {
      Merotele = 'location',
      latitude = latitude,
      longitude = longitude
    },
    query = tostring(query),
    offset = tostring(offset)
  }
end
function Merotele_function.answerCallbackQuery(callback_query_id, text, show_alert, url, cache_time)
  return function_core.run_table{
        Merotele = 'answerCallbackQuery',
        callback_query_id = callback_query_id,
        show_alert = show_alert,
        cache_time = cache_time,
        text = text,
        url = url,
  }
end
function Merotele_function.getCallbackQueryAnswer(chat_id, message_id, payload, data, game_short_name)
  return function_core.run_table{
    Merotele = 'getCallbackQueryAnswer',
    chat_id = chat_id,
    message_id = message_id,
    payload = {
      Merotele = 'callbackQueryPayload' .. payload,
      data = data,
      game_short_name = game_short_name
    }
  }
end
function Merotele_function.deleteChatReplyMarkup(chat_id, message_id)
  return function_core.run_table{
    Merotele = 'deleteChatReplyMarkup',
    chat_id = chat_id,
    message_id = message_id
  }
end
function Merotele_function.sendChatAction(chat_id, action, progress)
  return function_core.run_table{
    Merotele = 'sendChatAction',
    chat_id = chat_id,
    action = {
      Merotele = 'chatAction' .. action,
      progress = progress or 100
    }
  }
end
function Merotele_function.openChat(chat_id)
  return function_core.run_table{
    Merotele = 'openChat',
    chat_id = chat_id
  }
end
function Merotele_function.closeChat(chat_id)
  return function_core.run_table{
    Merotele = 'closeChat',
    chat_id = chat_id
  }
end
function Merotele_function.viewMessages(chat_id, message_ids, force_read)
  return function_core.run_table{
    Merotele = 'viewMessages',
    chat_id = chat_id,
    message_ids = Merotele_function.vectorize(message_ids),
    force_read = force_read
  }
end
function Merotele_function.openMessageContent(chat_id, message_id)
  return function_core.run_table{
    Merotele = 'openMessageContent',
    chat_id = chat_id,
    message_id = message_id
  }
end
function Merotele_function.readAllChatMentions(chat_id)
  return function_core.run_table{
    Merotele = 'readAllChatMentions',
    chat_id = chat_id
  }
end
function Merotele_function.createPrivateChat(user_id, force)
  return function_core.run_table{
    Merotele = 'createPrivateChat',
    user_id = user_id,
    force = force
  }
end
function Merotele_function.createBasicGroupChat(basic_group_id, force)
  return function_core.run_table{
    Merotele = 'createBasicGroupChat',
    basic_group_id = Merotele_function.getChatId(basic_group_id).id,
    force = force
  }
end
function Merotele_function.createSupergroupChat(supergroup_id, force)
  return function_core.run_table{
    Merotele = 'createSupergroupChat',
    supergroup_id = Merotele_function.getChatId(supergroup_id).id,
    force = force
  }
end
function Merotele_function.createSecretChat(secret_chat_id)
  return function_core.run_table{
    Merotele = 'createSecretChat',
    secret_chat_id = secret_chat_id
  }
end
function Merotele_function.createNewBasicGroupChat(user_ids, title)
  return function_core.run_table{
    Merotele = 'createNewBasicGroupChat',
    user_ids = Merotele_function.vectorize(user_ids),
    title = tostring(title)
  }
end
function Merotele_function.createNewSupergroupChat(title, is_channel, description)
  return function_core.run_table{
    Merotele = 'createNewSupergroupChat',
    title = tostring(title),
    is_channel = is_channel,
    description = tostring(description)
  }
end
function Merotele_function.createNewSecretChat(user_id)
  return function_core.run_table{
    Merotele = 'createNewSecretChat',
    user_id = tonumber(user_id)
  }
end
function Merotele_function.upgradeBasicGroupChatToSupergroupChat(chat_id)
  return function_core.run_table{
    Merotele = 'upgradeBasicGroupChatToSupergroupChat',
    chat_id = chat_id
  }
end
function Merotele_function.setChatPermissions(chat_id, can_send_messages, can_send_media_messages, can_send_polls, can_send_other_messages, can_add_web_page_previews, can_change_info, can_invite_users, can_pin_messages)
  return function_core.run_table{
    Merotele = 'setChatPermissions',
    chat_id = chat_id,
     permissions = {
      can_send_messages = can_send_messages,
      can_send_media_messages = can_send_media_messages,
      can_send_polls = can_send_polls,
      can_send_other_messages = can_send_other_messages,
      can_add_web_page_previews = can_add_web_page_previews,
      can_change_info = can_change_info,
      can_invite_users = can_invite_users,
      can_pin_messages = can_pin_messages,
    }
  }
end
function Merotele_function.setChatTitle(chat_id, title)
  return function_core.run_table{
    Merotele = 'setChatTitle',
    chat_id = chat_id,
    title = tostring(title)
  }
end
function Merotele_function.setChatPhoto(chat_id, photo)
  return function_core.run_table{
    Merotele = 'setChatPhoto',
    chat_id = chat_id,
    photo = {Merotele = 'inputChatPhotoStatic', photo = Merotele_function.getInputFile(photo)}
  }
end 
function Merotele_function.setChatDraftMessage(chat_id, reply_to_message_id, text, parse_mode, disable_web_page_preview, clear_draft)
  local Merotele_body = {
    Merotele = 'setChatDraftMessage',
    chat_id = chat_id,
    draft_message = {
      Merotele = 'draftMessage',
      reply_to_message_id = reply_to_message_id,
      input_message_text = {
        Merotele = 'inputMessageText',
        disable_web_page_preview = disable_web_page_preview,
        text = {text = text},
        clear_draft = clear_draft
      }
    }
  }
  if parse_mode then
      Merotele_body.draft_message.input_message_text.text = Merotele_function.parseTextEntities(text, parse_mode)
  end
  return function_core.run_table(Merotele_body)
end
function Merotele_function.toggleChatIsPinned(chat_id, is_pinned)
  return function_core.run_table{
    Merotele = 'toggleChatIsPinned',
    chat_id = chat_id,
    is_pinned = is_pinned
  }
end
function Merotele_function.setChatClientData(chat_id, client_data)
  return function_core.run_table{
    Merotele = 'setChatClientData',
    chat_id = chat_id,
    client_data = tostring(client_data)
  }
end
function Merotele_function.addChatMember(chat_id, user_id, forward_limit)
  return function_core.run_table{
    Merotele = 'addChatMember',
    chat_id = chat_id,
    user_id = user_id,
    forward_limit = Merotele_function.setLimit(300, forward_limit)
  }
end
function Merotele_function.addChatMembers(chat_id, user_ids)
  return function_core.run_table{
    Merotele = 'addChatMembers',
    chat_id = chat_id,
    user_ids = Merotele_function.vectorize(user_ids)
  }
end
function Merotele_function.setChatMemberStatus(chat_id, user_id, status, right)
  local right = right and Merotele_function.vectorize(right) or {}
  local status = string.lower(status)
  if status == 'creator' then
    chat_member_status = {
      Merotele = 'chatMemberStatusCreator',
      is_member = right[1] or 1
    }
  elseif status == 'administrator' then
    chat_member_status = {
      Merotele = 'chatMemberStatusAdministrator',
      can_be_edited = right[1] or 1,
      can_change_info = right[2] or 0,
      can_post_messages = right[3] or 1,
      can_edit_messages = right[4] or 1,
      can_delete_messages = right[5] or 0,
      can_invite_users = right[6] or 1,
      can_restrict_members = right[7] or 0,
      can_pin_messages = right[8] or 0,
      can_manage_video_chats = right[9] or 0,
      is_anonymous = right[10] or 0,
      can_manage_chat = right[11] or 0,
      can_promote_members = right[12] or 0,
      custom_title = tostring(right[13]) or ''
    }
  elseif status == 'restricted' then
    chat_member_status = {
      permissions = {
        Merotele = 'chatPermissions',
        can_send_polls = right[2] or 0,
        can_add_web_page_previews = right[3] or 1,
        can_change_info = right[4] or 0,
        can_invite_users = right[5] or 1,
        can_pin_messages = right[6] or 0,
        can_send_media_messages = right[7] or 1,
        can_send_messages = right[8] or 1,
        can_send_other_messages = right[9] or 1
      },
      is_member = right[1] or 1,
      restricted_until_date = right[10] or 0,
      Merotele = 'chatMemberStatusRestricted'
    }
  elseif status == 'banned' then
    chat_member_status = {
      Merotele = 'chatMemberStatusBanned',
      banned_until_date = right[1] or 0
    }
  end
  return function_core.run_table{
    Merotele = 'setChatMemberStatus',
    chat_id = chat_id,
    member_id = {_='messageSenderUser', user_id = user_id},
    status = chat_member_status or {}
  }
end
function Merotele_function.SetAdmin(chat_id, user_id,right)
chat_member_status = {
      Merotele = 'chatMemberStatusAdministrator',
      can_be_edited = right[1] or 1,
      can_change_info = right[2] or 1,
      can_post_messages = right[3] or 1,
      can_edit_messages = right[4] or 1,
      can_delete_messages = right[5] or 1,
      can_invite_users = right[6] or 1,
      can_restrict_members = right[7] or 1,
      can_pin_messages = right[8] or 1,
      can_manage_video_chats = right[9] or 1,
      is_anonymous = right[10] or 1,
      can_manage_chat = right[11] or 1,
      can_promote_members = right[12] or 0,
      custom_title = tostring(right[13]) or ''
    }
return function_core.run_table{
    Merotele = 'setChatMemberStatus',
    chat_id = chat_id,
    member_id = {_='messageSenderUser', user_id = user_id},
    status = chat_member_status or {}
  }
end

function Merotele_function.getChatMember(chat_id, user_id)
  return function_core.run_table{
    Merotele = 'getChatMember',
    chat_id = chat_id,
    member_id = {_='messageSenderUser', user_id = user_id}
  }
end 
function Merotele_function.searchChatMembers(chat_id, query, limit)
  return function_core.run_table{
    Merotele = 'searchChatMembers',
    chat_id = chat_id,
    query = tostring(query),
    limit = Merotele_function.setLimit(200, limit)
  }
end
function Merotele_function.getChatAdministrators(chat_id)
  return function_core.run_table{
    Merotele = 'getChatAdministrators',
    chat_id = chat_id
  }
end
function Merotele_function.setPinnedChats(chat_ids)
  return function_core.run_table{
    Merotele = 'setPinnedChats',
    chat_ids = Merotele_function.vectorize(chat_ids)
  }
end
function Merotele_function.downloadFile(file_id, priority)
  return function_core.run_table{
    Merotele = 'downloadFile',
    file_id = file_id,
    priority = priority or 32
  }
end
function Merotele_function.cancelDownloadFile(file_id, only_if_pending)
  return function_core.run_table{
    Merotele = 'cancelDownloadFile',
    file_id = file_id,
    only_if_pending = only_if_pending
  }
end
function Merotele_function.uploadFile(file, file_type, priority)
  local ftype = file_type or 'Unknown'
  return function_core.run_table{
    Merotele = 'uploadFile',
    file = Merotele_function.getInputFile(file),
    file_type = {
      Merotele = 'fileType' .. ftype
    },
    priority = priority or 32
  }
end
function Merotele_function.cancelUploadFile(file_id)
  return function_core.run_table{
    Merotele = 'cancelUploadFile',
    file_id = file_id
  }
end
function Merotele_function.deleteFile(file_id)
  return function_core.run_table{
    Merotele = 'deleteFile',
    file_id = file_id
  }
end
function Merotele_function.generateChatInviteLink(chat_id,name,expire_date,member_limit,creates_join_request)
  return function_core.run_table{
    Merotele = 'createChatInviteLink',
    chat_id = chat_id,
    name = tostring(name),
    expire_date = tonumber(expire_date),
    member_limit = tonumber(member_limit),
    creates_join_request = creates_join_request
  }
end 
function Merotele_function.joinChatByUsernam(username)
  if type(username) == 'string' and 5 <= #username then
    local result = Merotele_function.searchPublicChat(username)
    if result.type and result.type.Merotele == 'chatTypeSupergroup' then
      return function_core.run_table{
        Merotele = 'joinChat',
        chat_id = result.id
      }
    else
      return result
    end
  end
end
function Merotele_function.checkChatInviteLink(invite_link)
  return function_core.run_table{
    Merotele = 'checkChatInviteLink',
    invite_link = tostring(invite_link)
  }
end
function Merotele_function.joinChatByInviteLink(invite_link)
  return function_core.run_table{
    Merotele = 'joinChatByInviteLink',
    invite_link = tostring(invite_link)
  }
end
function Merotele_function.leaveChat(chat_id)
  return  function_core.run_table{
    Merotele = 'leaveChat',
    chat_id = chat_id
  }
end
function Merotele_function.createCall(user_id, udp_p2p, udp_reflector, min_layer, max_layer)
  return function_core.run_table{
    Merotele = 'createCall',
    user_id = user_id,
    protocol = {
      Merotele = 'callProtocol',
      udp_p2p = udp_p2p,
      udp_reflector = udp_reflector,
      min_layer = min_layer or 65,
      max_layer = max_layer or 65
    }
  }
end
function Merotele_function.acceptCall(call_id, udp_p2p, udp_reflector, min_layer, max_layer)
  return function_core.run_table{
    Merotele = 'acceptCall',
    call_id = call_id,
    protocol = {
      Merotele = 'callProtocol',
      udp_p2p = udp_p2p,
      udp_reflector = udp_reflector,
      min_layer = min_layer or 65,
      max_layer = max_layer or 65
    }
  }
end
function Merotele_function.blockUser(user_id)
  return function_core.run_table{
    Merotele = 'blockUser',
    user_id = user_id
  }
end
function Merotele_function.unblockUser(user_id)
  return function_core.run_table{
    Merotele = 'unblockUser',
    user_id = user_id
  }
end
function Merotele_function.getBlockedUsers(offset, limit)
  return function_core.run_table{
    Merotele = 'getBlockedUsers',
    offset = offset or 0,
    limit = Merotele_function.setLimit(100, limit)
  }
end
function Merotele_function.getContacts()
  return function_core.run_table{
    Merotele = 'getContacts'
  }
end
function Merotele_function.importContacts(contacts)
  local result = {}
  for key, value in pairs(contacts) do
    result[#result + 1] = {
      Merotele = 'contact',
      phone_number = tostring(value.phone_number),
      first_name = tostring(value.first_name),
      last_name = tostring(value.last_name),
      user_id = value.user_id or 0
    }
  end
  return function_core.run_table{
    Merotele = 'importContacts',
    contacts = result
  }
end
function Merotele_function.searchContacts(query, limit)
  return function_core.run_table{
    Merotele = 'searchContacts',
    query = tostring(query),
    limit = limit
  }
end
function Merotele_function.removeContacts(user_ids)
  return function_core.run_table{
    Merotele = 'removeContacts',
    user_ids = Merotele_function.vectorize(user_ids)
  }
end
function Merotele_function.getImportedContactCount()
  return function_core.run_table{
    Merotele = 'getImportedContactCount'
  }
end
function Merotele_function.changeImportedContacts(phone_number, first_name, last_name, user_id)
  return function_core.run_table{
    Merotele = 'changeImportedContacts',
    contacts = {
      Merotele = 'contact',
      phone_number = tostring(phone_number),
      first_name = tostring(first_name),
      last_name = tostring(last_name),
      user_id = user_id or 0
    }
  }
end
function Merotele_function.clearImportedContacts()
  return function_core.run_table{
    Merotele = 'clearImportedContacts'
  }
end
function Merotele_function.getUserProfilePhotos(user_id, offset, limit)
  return function_core.run_table{
    Merotele = 'getUserProfilePhotos',
    user_id = user_id,
    offset = offset or 0,
    limit = Merotele_function.setLimit(100, limit)
  }
end
function Merotele_function.getStickers(emoji, limit)
  return function_core.run_table{
    Merotele = 'getStickers',
    emoji = tostring(emoji),
    limit = Merotele_function.setLimit(100, limit)
  }
end
function Merotele_function.searchStickers(emoji, limit)
  return function_core.run_table{
    Merotele = 'searchStickers',
    emoji = tostring(emoji),
    limit = limit
  }
end
function Merotele_function.getArchivedStickerSets(is_masks, offset_sticker_set_id, limit)
  return function_core.run_table{
    Merotele = 'getArchivedStickerSets',
    is_masks = is_masks,
    offset_sticker_set_id = offset_sticker_set_id,
    limit = limit
  }
end
function Merotele_function.getTrendingStickerSets()
  return function_core.run_table{
    Merotele = 'getTrendingStickerSets'
  }
end
function Merotele_function.getAttachedStickerSets(file_id)
  return function_core.run_table{
    Merotele = 'getAttachedStickerSets',
    file_id = file_id
  }
end
function Merotele_function.getStickerSet(set_id)
  return function_core.run_table{
    Merotele = 'getStickerSet',
    set_id = set_id
  }
end
function Merotele_function.searchStickerSet(name)
  return function_core.run_table{
    Merotele = 'searchStickerSet',
    name = tostring(name)
  }
end
function Merotele_function.searchInstalledStickerSets(is_masks, query, limit)
  return function_core.run_table{
    Merotele = 'searchInstalledStickerSets',
    is_masks = is_masks,
    query = tostring(query),
    limit = limit
  }
end
function Merotele_function.searchStickerSets(query)
  return function_core.run_table{
    Merotele = 'searchStickerSets',
    query = tostring(query)
  }
end
function Merotele_function.changeStickerSet(set_id, is_installed, is_archived)
  return function_core.run_table{
    Merotele = 'changeStickerSet',
    set_id = set_id,
    is_installed = is_installed,
    is_archived = is_archived
  }
end
function Merotele_function.viewTrendingStickerSets(sticker_set_ids)
  return function_core.run_table{
    Merotele = 'viewTrendingStickerSets',
    sticker_set_ids = Merotele_function.vectorize(sticker_set_ids)
  }
end
function Merotele_function.reorderInstalledStickerSets(is_masks, sticker_set_ids)
  return function_core.run_table{
    Merotele = 'reorderInstalledStickerSets',
    is_masks = is_masks,
    sticker_set_ids = Merotele_function.vectorize(sticker_set_ids)
  }
end
function Merotele_function.getRecentStickers(is_attached)
  return function_core.run_table{
    Merotele = 'getRecentStickers',
    is_attached = is_attached
  }
end
function Merotele_function.addRecentSticker(is_attached, sticker)
  return function_core.run_table{
    Merotele = 'addRecentSticker',
    is_attached = is_attached,
    sticker = Merotele_function.getInputFile(sticker)
  }
end
function Merotele_function.clearRecentStickers(is_attached)
  return function_core.run_table{
    Merotele = 'clearRecentStickers',
    is_attached = is_attached
  }
end
function Merotele_function.getFavoriteStickers()
  return function_core.run_table{
    Merotele = 'getFavoriteStickers'
  }
end
function Merotele_function.addFavoriteSticker(sticker)
  return function_core.run_table{
    Merotele = 'addFavoriteSticker',
    sticker = Merotele_function.getInputFile(sticker)
  }
end
function Merotele_function.removeFavoriteSticker(sticker)
  return function_core.run_table{
    Merotele = 'removeFavoriteSticker',
    sticker = Merotele_function.getInputFile(sticker)
  }
end
function Merotele_function.getStickerEmojis(sticker)
  return function_core.run_table{
    Merotele = 'getStickerEmojis',
    sticker = Merotele_function.getInputFile(sticker)
  }
end
function Merotele_function.getSavedAnimations()
  return function_core.run_table{
    Merotele = 'getSavedAnimations'
  }
end
function Merotele_function.addSavedAnimation(animation)
  return function_core.run_table{
    Merotele = 'addSavedAnimation',
    animation = Merotele_function.getInputFile(animation)
  }
end
function Merotele_function.removeSavedAnimation(animation)
  return function_core.run_table{
    Merotele = 'removeSavedAnimation',
    animation = Merotele_function.getInputFile(animation)
  }
end
function Merotele_function.getRecentInlineBots()
  return function_core.run_table{
    Merotele = 'getRecentInlineBots'
  }
end
function Merotele_function.searchHashtags(prefix, limit)
  return function_core.run_table{
    Merotele = 'searchHashtags',
    prefix = tostring(prefix),
    limit = limit
  }
end
function Merotele_function.removeRecentHashtag(hashtag)
  return function_core.run_table{
    Merotele = 'removeRecentHashtag',
    hashtag = tostring(hashtag)
  }
end
function Merotele_function.getWebPagePreview(text)
  return function_core.run_table{
    Merotele = 'getWebPagePreview',
    text = {
      text = text
    }
  }
end
function Merotele_function.getWebPageInstantView(url, force_full)
  return function_core.run_table{
    Merotele = 'getWebPageInstantView',
    url = tostring(url),
    force_full = force_full
  }
end
function Merotele_function.getNotificationSettings(scope, chat_id)
  return function_core.run_table{
    Merotele = 'getNotificationSettings',
    scope = {
      Merotele = 'notificationSettingsScope' .. scope,
      chat_id = chat_id
    }
  }
end
function Merotele_function.setNotificationSettings(scope, chat_id, mute_for, sound, show_preview)
  return function_core.run_table{
    Merotele = 'setNotificationSettings',
    scope = {
      Merotele = 'notificationSettingsScope' .. scope,
      chat_id = chat_id
    },
    notification_settings = {
      Merotele = 'notificationSettings',
      mute_for = mute_for,
      sound = tostring(sound),
      show_preview = show_preview
    }
  }
end
function Merotele_function.resetAllNotificationSettings()
  return function_core.run_table{
    Merotele = 'resetAllNotificationSettings'
  }
end
function Merotele_function.setProfilePhoto(photo)
  return function_core.run_table{
    Merotele = 'setProfilePhoto',
    photo = Merotele_function.getInputFile(photo)
  }
end
function Merotele_function.deleteProfilePhoto(profile_photo_id)
  return function_core.run_table{
    Merotele = 'deleteProfilePhoto',
    profile_photo_id = profile_photo_id
  }
end
function Merotele_function.setName(first_name, last_name)
  return function_core.run_table{
    Merotele = 'setName',
    first_name = tostring(first_name),
    last_name = tostring(last_name)
  }
end
function Merotele_function.setBio(bio)
  return function_core.run_table{
    Merotele = 'setBio',
    bio = tostring(bio)
  }
end
function Merotele_function.setUsername(username)
  return function_core.run_table{
    Merotele = 'setUsername',
    username = tostring(username)
  }
end
function Merotele_function.getActiveSessions()
  return function_core.run_table{
    Merotele = 'getActiveSessions'
  }
end
function Merotele_function.terminateAllOtherSessions()
  return function_core.run_table{
    Merotele = 'terminateAllOtherSessions'
  }
end
function Merotele_function.terminateSession(session_id)
  return function_core.run_table{
    Merotele = 'terminateSession',
    session_id = session_id
  }
end
function Merotele_function.toggleBasicGroupAdministrators(basic_group_id, everyone_is_administrator)
  return function_core.run_table{
    Merotele = 'toggleBasicGroupAdministrators',
    basic_group_id = Merotele_function.getChatId(basic_group_id).id,
    everyone_is_administrator = everyone_is_administrator
  }
end
function Merotele_function.setSupergroupUsername(supergroup_id, username)
  return function_core.run_table{
    Merotele = 'setSupergroupUsername',
    supergroup_id = Merotele_function.getChatId(supergroup_id).id,
    username = tostring(username)
  }
end
function Merotele_function.setSupergroupStickerSet(supergroup_id, sticker_set_id)
  return function_core.run_table{
    Merotele = 'setSupergroupStickerSet',
    supergroup_id = Merotele_function.getChatId(supergroup_id).id,
    sticker_set_id = sticker_set_id
  }
end
function Merotele_function.toggleSupergroupInvites(supergroup_id, anyone_can_invite)
  return function_core.run_table{
    Merotele = 'toggleSupergroupInvites',
    supergroup_id = Merotele_function.getChatId(supergroup_id).id,
    anyone_can_invite = anyone_can_invite
  }
end
function Merotele_function.toggleSupergroupSignMessages(supergroup_id, sign_messages)
  return function_core.run_table{
    Merotele = 'toggleSupergroupSignMessages',
    supergroup_id = Merotele_function.getChatId(supergroup_id).id,
    sign_messages = sign_messages
  }
end
function Merotele_function.toggleSupergroupIsAllHistoryAvailable(supergroup_id, is_all_history_available)
  return function_core.run_table{
    Merotele = 'toggleSupergroupIsAllHistoryAvailable',
    supergroup_id = Merotele_function.getChatId(supergroup_id).id,
    is_all_history_available = is_all_history_available
  }
end
function Merotele_function.setChatDescription(chat_id, description)
  return function_core.run_table{
    Merotele = 'setChatDescription',
    chat_id = chat_id,
    description = tostring(description)
  }
end
function Merotele_function.pinChatMessage(chat_id, message_id, disable_notification)
  return function_core.run_table{
    Merotele = 'pinChatMessage',
    chat_id = chat_id,
    message_id = message_id,
    disable_notification = disable_notification
  }
end
function Merotele_function.unpinChatMessage(chat_id)
  return function_core.run_table{
    Merotele = 'unpinChatMessage',
    chat_id = chat_id
  }
end
function Merotele_function.reportSupergroupSpam(supergroup_id, user_id, message_ids)
  return function_core.run_table{
    Merotele = 'reportSupergroupSpam',
    supergroup_id = Merotele_function.getChatId(supergroup_id).id,
    user_id = user_id,
    message_ids = Merotele_function.vectorize(message_ids)
  }
end
function Merotele_function.getSupergroupMembers(supergroup_id, filter, query, offset, limit)
  local filter = filter or 'Recent'
  return function_core.run_table{
    Merotele = 'getSupergroupMembers',
    supergroup_id = Merotele_function.getChatId(supergroup_id).id,
    filter = {
      Merotele = 'supergroupMembersFilter' .. filter,
      query = query
    },
    offset = offset or 0,
    limit = Merotele_function.setLimit(200, limit)
  }
end
function Merotele_function.deleteSupergroup(supergroup_id)
  return function_core.run_table{
    Merotele = 'deleteSupergroup',
    supergroup_id = Merotele_function.getChatId(supergroup_id).id
  }
end
function Merotele_function.closeSecretChat(secret_chat_id)
  return function_core.run_table{
    Merotele = 'closeSecretChat',
    secret_chat_id = secret_chat_id
  }
end
function Merotele_function.getChatEventLog(chat_id, query, from_event_id, limit, filters, user_ids)
  local filters = filters or {1,1,1,1,1,1,1,1,1,1}
  return function_core.run_table{
    Merotele = 'getChatEventLog',
    chat_id = chat_id,
    query = tostring(query) or '',
    from_event_id = from_event_id or 0,
    limit = Merotele_function.setLimit(100, limit),
    filters = {
      Merotele = 'chatEventLogFilters',
      message_edits = filters[0],
      message_deletions = filters[1],
      message_pins = filters[2],
      member_joins = filters[3],
      member_leaves = filters[4],
      member_invites = filters[5],
      member_promotions = filters[6],
      member_restrictions = filters[7],
      info_changes = filters[8],
      setting_changes = filters[9]
    },
    user_ids = Merotele_function.vectorize(user_ids)
  }
end
function Merotele_function.getSavedOrderInfo()
  return function_core.run_table{
    Merotele = 'getSavedOrderInfo'
  }
end
function Merotele_function.deleteSavedOrderInfo()
  return function_core.run_table{
    Merotele = 'deleteSavedOrderInfo'
  }
end
function Merotele_function.deleteSavedCredentials()
  return function_core.run_table{
    Merotele = 'deleteSavedCredentials'
  }
end
function Merotele_function.getSupportUser()
  return function_core.run_table{
    Merotele = 'getSupportUser'
  }
end
function Merotele_function.getWallpapers()
  return function_core.run_table{
    Merotele = 'getWallpapers'
  }
end
function Merotele_function.setUserPrivacySettingRules(setting, rules, allowed_user_ids, restricted_user_ids)
  local setting_rules = {
    [0] = {
      Merotele = 'userPrivacySettingRule' .. rules
    }
  }
  if allowed_user_ids then
    setting_rules[#setting_rules + 1] = {
      {
        Merotele = 'userPrivacySettingRuleAllowUsers',
        user_ids = Merotele_function.vectorize(allowed_user_ids)
      }
    }
  elseif restricted_user_ids then
    setting_rules[#setting_rules + 1] = {
      {
        Merotele = 'userPrivacySettingRuleRestrictUsers',
        user_ids = Merotele_function.vectorize(restricted_user_ids)
      }
    }
  end
  return function_core.run_table{
    Merotele = 'setUserPrivacySettingRules',
    setting = {
      Merotele = 'userPrivacySetting' .. setting
    },
    rules = {
      Merotele = 'userPrivacySettingRules',
      rules = setting_rules
    }
  }
end
function Merotele_function.getUserPrivacySettingRules(setting)
  return function_core.run_table{
    Merotele = 'getUserPrivacySettingRules',
    setting = {
      Merotele = 'userPrivacySetting' .. setting
    }
  }
end
function Merotele_function.getOption(name)
  return function_core.run_table{
    Merotele = 'getOption',
    name = tostring(name)
  }
end
function Merotele_function.setOption(name, option_value, value)
  return function_core.run_table{
    Merotele = 'setOption',
    name = tostring(name),
    value = {
      Merotele = 'optionValue' .. option_value,
      value = value
    }
  }
end
function Merotele_function.setAccountTtl(ttl)
  return function_core.run_table{
    Merotele = 'setAccountTtl',
    ttl = {
      Merotele = 'accountTtl',
      days = ttl
    }
  }
end
function Merotele_function.getAccountTtl()
  return function_core.run_table{
    Merotele = 'getAccountTtl'
  }
end
function Merotele_function.deleteAccount(reason)
  return function_core.run_table{
    Merotele = 'deleteAccount',
    reason = tostring(reason)
  }
end
function Merotele_function.getChatReportSpamState(chat_id)
  return function_core.run_table{
    Merotele = 'getChatReportSpamState',
    chat_id = chat_id
  }
end
function Merotele_function.reportChat(chat_id, reason, text, message_ids)
  return function_core.run_table{
    Merotele = 'reportChat',
    chat_id = chat_id,
    reason = {
      Merotele = 'chatReportReason' .. reason,
      text = text
    },
    message_ids = Merotele_function.vectorize(message_ids)
  }
end
function Merotele_function.getStorageStatistics(chat_limit)
  return function_core.run_table{
    Merotele = 'getStorageStatistics',
    chat_limit = chat_limit
  }
end
function Merotele_function.getStorageStatisticsFast()
  return function_core.run_table{
    Merotele = 'getStorageStatisticsFast'
  }
end
function Merotele_function.optimizeStorage(size, ttl, count, immunity_delay, file_type, chat_ids, exclude_chat_ids, chat_limit)
  local file_type = file_type or ''
  return function_core.run_table{
    Merotele = 'optimizeStorage',
    size = size or -1,
    ttl = ttl or -1,
    count = count or -1,
    immunity_delay = immunity_delay or -1,
    file_type = {
      Merotele = 'fileType' .. file_type
    },
    chat_ids = Merotele_function.vectorize(chat_ids),
    exclude_chat_ids = Merotele_function.vectorize(exclude_chat_ids),
    chat_limit = chat_limit
  }
end
function Merotele_function.setNetworkType(type)
  return function_core.run_table{
    Merotele = 'setNetworkType',
    type = {
      Merotele = 'networkType' .. type
    },
  }
end
function Merotele_function.getNetworkStatistics(only_current)
  return function_core.run_table{
    Merotele = 'getNetworkStatistics',
    only_current = only_current
  }
end
function Merotele_function.addNetworkStatistics(entry, file_type, network_type, sent_bytes, received_bytes, duration)
  local file_type = file_type or 'None'
  return function_core.run_table{
    Merotele = 'addNetworkStatistics',
    entry = {
      Merotele = 'networkStatisticsEntry' .. entry,
      file_type = {
        Merotele = 'fileType' .. file_type
      },
      network_type = {
        Merotele = 'networkType' .. network_type
      },
      sent_bytes = sent_bytes,
      received_bytes = received_bytes,
      duration = duration
    }
  }
end
function Merotele_function.resetNetworkStatistics()
  return function_core.run_table{
    Merotele = 'resetNetworkStatistics'
  }
end
function Merotele_function.getCountryCode()
  return function_core.run_table{
    Merotele = 'getCountryCode'
  }
end
function Merotele_function.getInviteText()
  return function_core.run_table{
    Merotele = 'getInviteText'
  }
end
function Merotele_function.getTermsOfService()
  return function_core.run_table{
    Merotele = 'getTermsOfService'
  }
end
function Merotele_function.sendText(chat_id, reply_to_message_id, text, parse_mode, disable_web_page_preview, clear_draft, disable_notification, from_background, reply_markup)
  local input_message_content = {
    Merotele = 'inputMessageText',
    disable_web_page_preview = disable_web_page_preview,
    text = {text = text},
    clear_draft = clear_draft
  }
  return Merotele_function.sendMessage(chat_id, reply_to_message_id, input_message_content, parse_mode, disable_notification, from_background, reply_markup)
end
function Merotele_function.sendAnimation(chat_id, reply_to_message_id, animation, caption, parse_mode, duration, width, height, thumbnail, thumb_width, thumb_height, disable_notification, from_background, reply_markup)
  local input_message_content = {
    Merotele = 'inputMessageAnimation',
    animation = Merotele_function.getInputFile(animation),
    thumbnail = {
      Merotele = 'inputThumbnail',
      thumbnail = Merotele_function.getInputFile(thumbnail),
      width = thumb_width,
      height = thumb_height
    },
    caption = {text = caption},
    duration = duration,
    width = width,
    height = height
  }
  return Merotele_function.sendMessage(chat_id, reply_to_message_id, input_message_content, parse_mode, disable_notification, from_background, reply_markup)
end
function Merotele_function.sendAudio(chat_id, reply_to_message_id, audio, caption, parse_mode, duration, title, performer, thumbnail, thumb_width, thumb_height, disable_notification, from_background, reply_markup)
  local input_message_content = {
    Merotele = 'inputMessageAudio',
    audio = Merotele_function.getInputFile(audio),
    album_cover_thumbnail = {
      Merotele = 'inputThumbnail',
      thumbnail = Merotele_function.getInputFile(thumbnail),
      width = thumb_width,
      height = thumb_height
    },
    caption = {text = caption},
    duration = duration,
    title = tostring(title),
    performer = tostring(performer)
  }
  return Merotele_function.sendMessage(chat_id, reply_to_message_id, input_message_content, parse_mode, disable_notification, from_background, reply_markup)
end
function Merotele_function.sendDocument(chat_id, reply_to_message_id, document, caption, parse_mode, thumbnail, thumb_width, thumb_height, disable_notification, from_background, reply_markup)
  local input_message_content = {
    Merotele = 'inputMessageDocument',
    document = Merotele_function.getInputFile(document),
    thumbnail = {
      Merotele = 'inputThumbnail',
      thumbnail = Merotele_function.getInputFile(thumbnail),
      width = thumb_width,
      height = thumb_height
    },
    caption = {text = caption}
  }
  return Merotele_function.sendMessage(chat_id, reply_to_message_id, input_message_content, parse_mode, disable_notification, from_background, reply_markup)
end
function Merotele_function.sendPhoto(chat_id, reply_to_message_id, photo, caption, parse_mode, added_sticker_file_ids, width, height, ttl, thumbnail, thumb_width, thumb_height, disable_notification, from_background, reply_markup)
  local input_message_content = {
    Merotele = 'inputMessagePhoto',
    photo = Merotele_function.getInputFile(photo),
    thumbnail = {
      Merotele = 'inputThumbnail',
      thumbnail = Merotele_function.getInputFile(thumbnail),
      width = thumb_width,
      height = thumb_height
    },
    caption = {text = caption},
    added_sticker_file_ids = Merotele_function.vectorize(added_sticker_file_ids),
    width = width,
    height = height,
    ttl = ttl or 0
  }
  return Merotele_function.sendMessage(chat_id, reply_to_message_id, input_message_content, parse_mode, disable_notification, from_background, reply_markup)
end
function Merotele_function.sendSticker(chat_id, reply_to_message_id, sticker, width, height, disable_notification, thumbnail, thumb_width, thumb_height, from_background, reply_markup)
  local input_message_content = {
    Merotele = 'inputMessageSticker',
    sticker = Merotele_function.getInputFile(sticker),
    thumbnail = {
      Merotele = 'inputThumbnail',
      thumbnail = Merotele_function.getInputFile(thumbnail),
      width = thumb_width,
      height = thumb_height
    },
    width = width,
    height = height
  }
  return Merotele_function.sendMessage(chat_id, reply_to_message_id, input_message_content, nil, disable_notification, from_background, reply_markup)
end
function Merotele_function.sendVideo(chat_id, reply_to_message_id, video, caption, parse_mode, added_sticker_file_ids, duration, width, height, ttl, thumbnail, thumb_width, thumb_height, disable_notification, from_background, reply_markup)
  local input_message_content = {
    Merotele = 'inputMessageVideo',
    video = Merotele_function.getInputFile(video),
    thumbnail = {
      Merotele = 'inputThumbnail',
      thumbnail = Merotele_function.getInputFile(thumbnail),
      width = thumb_width,
      height = thumb_height
    },
    caption = {text = caption},
    added_sticker_file_ids = Merotele_function.vectorize(added_sticker_file_ids),
    duration = duration,
    width = width,
    height = height,
    ttl = ttl
  }
  return Merotele_function.sendMessage(chat_id, reply_to_message_id, input_message_content, parse_mode, disable_notification, from_background, reply_markup)
end
function Merotele_function.sendVideoNote(chat_id, reply_to_message_id, video_note, duration, length, thumbnail, thumb_width, thumb_height, disable_notification, from_background, reply_markup)
  local input_message_content = {
    Merotele = 'inputMessageVideoNote',
    video_note = Merotele_function.getInputFile(video_note),
    thumbnail = {
      Merotele = 'inputThumbnail',
      thumbnail = Merotele_function.getInputFile(thumbnail),
      width = thumb_width,
      height = thumb_height
    },
    duration = duration,
    length = length
  }
  return Merotele_function.sendMessage(chat_id, reply_to_message_id, input_message_content, nil, disable_notification, from_background, reply_markup)
end
function Merotele_function.sendVoiceNote(chat_id, reply_to_message_id, voice_note, caption, parse_mode, duration, waveform, disable_notification, from_background, reply_markup)
  local input_message_content = {
    Merotele = 'inputMessageVoiceNote',
    voice_note = Merotele_function.getInputFile(voice_note),
    caption = {text = caption},
    duration = duration,
    waveform = waveform
  }
  return Merotele_function.sendMessage(chat_id, reply_to_message_id, input_message_content, parse_mode, disable_notification, from_background, reply_markup)
end
function Merotele_function.sendLocation(chat_id, reply_to_message_id, latitude, longitude, disable_notification, from_background, reply_markup)
  local input_message_content = {
    Merotele = 'inputMessageLocation',
    location = {
      Merotele = 'location',
      latitude = latitude,
      longitude = longitude
    },
    live_period = liveperiod
  }
  return Merotele_function.sendMessage(chat_id, reply_to_message_id, input_message_content, nil, disable_notification, from_background, reply_markup)
end
function Merotele_function.sendVenue(chat_id, reply_to_message_id, latitude, longitude, title, address, provider, id, disable_notification, from_background, reply_markup)
  local input_message_content = {
    Merotele = 'inputMessageVenue',
    venue = {
      Merotele = 'venue',
      location = {
        Merotele = 'location',
        latitude = latitude,
        longitude = longitude
      },
      title = tostring(title),
      address = tostring(address),
      provider = tostring(provider),
      id = tostring(id)
    }
  }
  return Merotele_function.sendMessage(chat_id, reply_to_message_id, input_message_content, nil, disable_notification, from_background, reply_markup)
end
function Merotele_function.sendContact(chat_id, reply_to_message_id, phone_number, first_name, last_name, user_id, disable_notification, from_background, reply_markup)
  local input_message_content = {
    Merotele = 'inputMessageContact',
    contact = {
      Merotele = 'contact',
      phone_number = tostring(phone_number),
      first_name = tostring(first_name),
      last_name = tostring(last_name),
      user_id = user_id
    }
  }
  return Merotele_function.sendMessage(chat_id, reply_to_message_id, input_message_content, nil, disable_notification, from_background, reply_markup)
end
function Merotele_function.sendInvoice(chat_id, reply_to_message_id, invoice, title, description, photo_url, photo_size, photo_width, photo_height, payload, provider_token, provider_data, start_parameter, disable_notification, from_background, reply_markup)
  local input_message_content = {
    Merotele = 'inputMessageInvoice',
    invoice = invoice,
    title = tostring(title),
    description = tostring(description),
    photo_url = tostring(photo_url),
    photo_size = photo_size,
    photo_width = photo_width,
    photo_height = photo_height,
    payload = payload,
    provider_token = tostring(provider_token),
    provider_data = tostring(provider_data),
    start_parameter = tostring(start_parameter)
  }
  return Merotele_function.sendMessage(chat_id, reply_to_message_id, input_message_content, nil, disable_notification, from_background, reply_markup)
end
function Merotele_function.sendForwarded(chat_id, reply_to_message_id, from_chat_id, message_id, in_game_share, disable_notification, from_background, reply_markup)
  local input_message_content = {
    Merotele = 'inputMessageForwarded',
    from_chat_id = from_chat_id,
    message_id = message_id,
    in_game_share = in_game_share
  }
  return Merotele_function.sendMessage(chat_id, reply_to_message_id, input_message_content, nil, disable_notification, from_background, reply_markup)
end
function Merotele_function.sendPoll(chat_id, reply_to_message_id, question, options, pollType, is_anonymous, allow_multiple_answers)
  local input_message_content = {
      Merotele = 'inputMessagePoll',
      is_anonymous = is_anonymous,
      question = question,
      type = {
        Merotele = 'pollType'..pollType,
        allow_multiple_answers = allow_multiple_answers
      },
      options = options
    }
  return Merotele_function.sendMessage(chat_id, reply_to_message_id, input_message_content, parse_mode, disable_notification, from_background, reply_markup)
end
function Merotele_function.getPollVoters(chat_id, message_id, option_id, offset, limit)
  return function_core.run_table{
    Merotele = 'getPollVoters',
    chat_id = chat_id,
    message_id = message_id,
    option_id = option_id,
    limit = Merotele_function.setLimit(50 , limit),
    offset = offset
  }
end
function Merotele_function.setPollAnswer(chat_id, message_id, option_ids)
  return function_core.run_table{
    Merotele = 'setPollAnswer',
    chat_id = chat_id,
    message_id = message_id,
    option_ids = option_ids
  }
end
function Merotele_function.stopPoll(chat_id, message_id, reply_markup)
  return function_core.run_table{
    Merotele = 'stopPoll',
    chat_id = chat_id,
    message_id = message_id,
    reply_markup = reply_markup
  }
end
function Merotele_function.getInputMessage(value)
  if type(value) ~= 'table' then
    return value
  end
  if type(value.type) == 'string' then
    if value.parse_mode and value.caption then
      caption = Merotele_function.parseTextEntities(value.caption, value.parse_mode)
    elseif value.caption and not value.parse_mode then
      caption = {
        text = value.caption
      }
    elseif value.parse_mode and value.text then
      text = Merotele_function.parseTextEntities(value.text, value.parse_mode)
    elseif not value.parse_mode and value.text then
      text = {
        text = value.text
      }
    end
    value.type = string.lower(value.type)
    if value.type == 'text' then
      return {
        Merotele = 'inputMessageText',
        disable_web_page_preview = value.disable_web_page_preview,
        text = text,
        clear_draft = value.clear_draft
      }
    elseif value.type == 'animation' then
      return {
        Merotele = 'inputMessageAnimation',
        animation = Merotele_function.getInputFile(value.animation),
        thumbnail = {
          Merotele = 'inputThumbnail',
          thumbnail = Merotele_function.getInputFile(value.thumbnail),
          width = value.thumb_width,
          height = value.thumb_height
        },
        caption = caption,
        duration = value.duration,
        width = value.width,
        height = value.height
      }
    elseif value.type == 'audio' then
      return {
        Merotele = 'inputMessageAudio',
        audio = Merotele_function.getInputFile(value.audio),
        album_cover_thumbnail = {
          Merotele = 'inputThumbnail',
          thumbnail = Merotele_function.getInputFile(value.thumbnail),
          width = value.thumb_width,
          height = value.thumb_height
        },
        caption = caption,
        duration = value.duration,
        title = tostring(value.title),
        performer = tostring(value.performer)
      }
    elseif value.type == 'document' then
      return {
        Merotele = 'inputMessageDocument',
        document = Merotele_function.getInputFile(value.document),
        thumbnail = {
          Merotele = 'inputThumbnail',
          thumbnail = Merotele_function.getInputFile(value.thumbnail),
          width = value.thumb_width,
          height = value.thumb_height
        },
        caption = caption
      }
    elseif value.type == 'photo' then
      return {
        Merotele = 'inputMessagePhoto',
        photo = Merotele_function.getInputFile(value.photo),
        thumbnail = {
          Merotele = 'inputThumbnail',
          thumbnail = Merotele_function.getInputFile(value.thumbnail),
          width = value.thumb_width,
          height = value.thumb_height
        },
        caption = caption,
        added_sticker_file_ids = Merotele_function.vectorize(value.added_sticker_file_ids),
        width = value.width,
        height = value.height,
        ttl = value.ttl or 0
      }
    elseif value.text == 'video' then
      return {
        Merotele = 'inputMessageVideo',
        video = Merotele_function.getInputFile(value.video),
        thumbnail = {
          Merotele = 'inputThumbnail',
          thumbnail = Merotele_function.getInputFile(value.thumbnail),
          width = value.thumb_width,
          height = value.thumb_height
        },
        caption = caption,
        added_sticker_file_ids = Merotele_function.vectorize(value.added_sticker_file_ids),
        duration = value.duration,
        width = value.width,
        height = value.height,
        ttl = value.ttl or 0
      }
    elseif value.text == 'videonote' then
      return {
        Merotele = 'inputMessageVideoNote',
        video_note = Merotele_function.getInputFile(value.video_note),
        thumbnail = {
          Merotele = 'inputThumbnail',
          thumbnail = Merotele_function.getInputFile(value.thumbnail),
          width = value.thumb_width,
          height = value.thumb_height
        },
        duration = value.duration,
        length = value.length
      }
    elseif value.text == 'voice' then
      return {
        Merotele = 'inputMessageVoiceNote',
        voice_note = Merotele_function.getInputFile(value.voice_note),
        caption = caption,
        duration = value.duration,
        waveform = value.waveform
      }
    elseif value.text == 'location' then
      return {
        Merotele = 'inputMessageLocation',
        location = {
          Merotele = 'location',
          latitude = value.latitude,
          longitude = value.longitude
        },
        live_period = value.liveperiod
      }
    elseif value.text == 'contact' then
      return {
        Merotele = 'inputMessageContact',
        contact = {
          Merotele = 'contact',
          phone_number = tostring(value.phone_number),
          first_name = tostring(value.first_name),
          last_name = tostring(value.last_name),
          user_id = value.user_id
        }
      }
    elseif value.text == 'contact' then
      return {
        Merotele = 'inputMessageContact',
        contact = {
          Merotele = 'contact',
          phone_number = tostring(value.phone_number),
          first_name = tostring(value.first_name),
          last_name = tostring(value.last_name),
          user_id = value.user_id
        }
      }
    end
  end
end
function Merotele_function.editInlineMessageText(inline_message_id, input_message_content, reply_markup)
  return function_core.run_table{
    Merotele = 'editInlineMessageText',
    input_message_content = Merotele_function.getInputMessage(input_message_content),
    reply_markup = reply_markup
  }
end
function Merotele_function.answerInlineQuery(inline_query_id, results, next_offset, switch_pm_text, switch_pm_parameter, is_personal, cache_time)
  local answerInlineQueryResults = {}
  for key, value in pairs(results) do
    local newAnswerInlineQueryResults_id = #answerInlineQueryResults + 1
    if type(value) == 'table' and type(value.type) == 'string' then
      value.type = string.lower(value.type)
      if value.type == 'gif' then
        answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
          Merotele = 'inputInlineQueryResultAnimatedGif',
          id = value.id,
          title = value.title,
          thumbnail_url = value.thumbnail_url,
          gif_url = value.gif_url,
          gif_duration = value.gif_duration,
          gif_width = value.gif_width,
          gif_height = value.gif_height,
          reply_markup = Merotele_function.replyMarkup{
            type = 'inline',
            data = value.reply_markup
          },
          input_message_content = Merotele_function.getInputMessage(value.input)
        }
      elseif value.type == 'mpeg4' then
        answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
          Merotele = 'inputInlineQueryResultAnimatedMpeg4',
          id = value.id,
          title = value.title,
          thumbnail_url = value.thumbnail_url,
          mpeg4_url = value.mpeg4_url,
          mpeg4_duration = value.mpeg4_duration,
          mpeg4_width = value.mpeg4_width,
          mpeg4_height = value.mpeg4_height,
          reply_markup = Merotele_function.replyMarkup{
            type = 'inline',
            data = value.reply_markup
          },
          input_message_content = Merotele_function.getInputMessage(value.input)
        }
      elseif value.type == 'article' then
        answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
          Merotele = 'inputInlineQueryResultArticle',
          id = value.id,
          url = value.url,
          hide_url = value.hide_url,
          title = value.title,
          description = value.description,
          thumbnail_url = value.thumbnail_url,
          thumbnail_width = value.thumbnail_width,
          thumbnail_height = value.thumbnail_height,
          reply_markup = Merotele_function.replyMarkup{
            type = 'inline',
            data = value.reply_markup
          },
          input_message_content = Merotele_function.getInputMessage(value.input)
        }
      elseif value.type == 'audio' then
        answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
          Merotele = 'inputInlineQueryResultAudio',
          id = value.id,
          title = value.title,
          performer = value.performer,
          audio_url = value.audio_url,
          audio_duration = value.audio_duration,
          reply_markup = Merotele_function.replyMarkup{
            type = 'inline',
            data = value.reply_markup
          },
          input_message_content = Merotele_function.getInputMessage(value.input)
        }
      elseif value.type == 'contact' then
        answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
          Merotele = 'inputInlineQueryResultContact',
          id = value.id,
          contact = value.contact,
          thumbnail_url = value.thumbnail_url,
          thumbnail_width = value.thumbnail_width,
          thumbnail_height = thumbnail_height.description,
          reply_markup = Merotele_function.replyMarkup{
            type = 'inline',
            data = value.reply_markup
          },
          input_message_content = Merotele_function.getInputMessage(value.input)
        }
      elseif value.type == 'document' then
        answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
          Merotele = 'inputInlineQueryResultDocument',
          id = value.id,
          title = value.title,
          description = value.description,
          document_url = value.document_url,
          mime_type = value.mime_type,
          thumbnail_url = value.thumbnail_url,
          thumbnail_width = value.thumbnail_width,
          thumbnail_height = value.thumbnail_height,
          reply_markup = Merotele_function.replyMarkup{
            type = 'inline',
            data = value.reply_markup
          },
          input_message_content = Merotele_function.getInputMessage(value.input)
        }
      elseif value.type == 'game' then
        answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
          Merotele = 'inputInlineQueryResultGame',
          id = value.id,
          game_short_name = value.game_short_name,
          reply_markup = Merotele_function.replyMarkup{
            type = 'inline',
            data = value.reply_markup
          },
          input_message_content = Merotele_function.getInputMessage(value.input)
        }
      elseif value.type == 'location' then
        answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
          Merotele = 'inputInlineQueryResultLocation',
          id = value.id,
          location = value.location,
          live_period = value.live_period,
          title = value.title,
          thumbnail_url = value.thumbnail_url,
          thumbnail_width = value.thumbnail_width,
          thumbnail_height = value.thumbnail_height,
          reply_markup = Merotele_function.replyMarkup{
            type = 'inline',
            data = value.reply_markup
          },
          input_message_content = Merotele_function.getInputMessage(value.input)
        }
      elseif value.type == 'photo' then
        answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
          Merotele = 'inputInlineQueryResultPhoto',
          id = value.id,
          title = value.title,
          description = value.description,
          thumbnail_url = value.thumbnail_url,
          photo_url = value.photo_url,
          photo_width = value.photo_width,
          photo_height = value.photo_height,
          reply_markup = Merotele_function.replyMarkup{
            type = 'inline',
            data = value.reply_markup
          },
          input_message_content = Merotele_function.getInputMessage(value.input)
        }
      elseif value.type == 'sticker' then
        answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
          Merotele = 'inputInlineQueryResultSticker',
          id = value.id,
          thumbnail_url = value.thumbnail_url,
          sticker_url = value.sticker_url,
          sticker_width = value.sticker_width,
          sticker_height = value.sticker_height,
          photo_width = value.photo_width,
          photo_height = value.photo_height,
          reply_markup = Merotele_function.replyMarkup{
            type = 'inline',
            data = value.reply_markup
          },
          input_message_content = Merotele_function.getInputMessage(value.input)
        }
      elseif value.type == 'sticker' then
        answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
          Merotele = 'inputInlineQueryResultSticker',
          id = value.id,
          thumbnail_url = value.thumbnail_url,
          sticker_url = value.sticker_url,
          sticker_width = value.sticker_width,
          sticker_height = value.sticker_height,
          photo_width = value.photo_width,
          photo_height = value.photo_height,
          reply_markup = Merotele_function.replyMarkup{
            type = 'inline',
            data = value.reply_markup
          },
          input_message_content = Merotele_function.getInputMessage(value.input)
        }
      elseif value.type == 'video' then
        answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
          Merotele = 'inputInlineQueryResultVideo',
          id = value.id,
          title = value.title,
          description = value.description,
          thumbnail_url = value.thumbnail_url,
          video_url = value.video_url,
          mime_type = value.mime_type,
          video_width = value.video_width,
          video_height = value.video_height,
          video_duration = value.video_duration,
          reply_markup = Merotele_function.replyMarkup{
            type = 'inline',
            data = value.reply_markup
          },
          input_message_content = Merotele_function.getInputMessage(value.input)
        }
      elseif value.type == 'videonote' then
        answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
          Merotele = 'inputInlineQueryResultVoiceNote',
          id = value.id,
          title = value.title,
          voice_note_url = value.voice_note_url,
          voice_note_duration = value.voice_note_duration,
          reply_markup = Merotele_function.replyMarkup{
            type = 'inline',
            data = value.reply_markup
          },
          input_message_content = Merotele_function.getInputMessage(value.input)
        }
      end
    end
  end
  return function_core.run_table{
    Merotele = 'answerInlineQuery',
    inline_query_id = inline_query_id,
    next_offset = next_offset,
    switch_pm_text = switch_pm_text,
    switch_pm_parameter = switch_pm_parameter,
    is_personal = is_personal,
    cache_time = cache_time,
    results = answerInlineQueryResults,
  }
end
function Merotele.VERSION()
  print(Merotele_function.colors('%{green}\27[5m'..Merotele.logo..'\n'..Merotele_function.base64_decode('VGhlIGZpbGVzIHdlcmUgd3JpdHRlbiBhbmQgZGV2ZWxvcGVkIGJ5IHRoZSBkZXZlbG9wZXIgOiBAQWJiYXNGYWRoaWwgLCBAV2FUYU5UZWFN')))
  return true
end
function Merotele.run(main_def, filters)
  if type(main_def) ~= 'function' then
    function_core.print_error('the run main_def must be a main function !')
    os.exit(1)
  else
    update_functions[0] = {}
    update_functions[0].def = main_def
    update_functions[0].filters = filters
  end
  while Merotele.get_update do
    for timer_id, timer_data in pairs(Merotele_timer) do
      if os.time() >= timer_data.run_in then
        xpcall(timer_data.def, function_core.print_error,timer_data.argv)
        table.remove(Merotele_timer,timer_id)
      end
    end
    local update = function_core.change_table(client:receive(1))
    if update then
      if type(update) ~= 'table' then
          goto finish
      end
      if Merotele.login(update) then
        function_core._CALL_(update)
      end
    end
    ::finish::
  end
end
function Merotele.set_config(data)
  Merotele.VERSION()
  if not data.api_hash then
    print(Merotele_function.colors('%{yellow} Please enter AP_HASH to call'))
    os.exit()
  end
  if not data.api_id then
    print(Merotele_function.colors('%{yellow} Please enter API_ID to call'))
    os.exit()
  end
  if not data.session_name then
    print(Merotele_function.colors('%{yellow} please use session_name in your script !'))
    os.exit()
  end
  if not data.token and not Merotele_function.exists('.CallBack-Bot/'..data.session_name) then
    io.write(Merotele_function.colors('\n%{green} Please enter Token or Phone to call'))
    local phone_token = io.read()
    if phone_token:match('%d+:') then
      Merotele.config.is_bot = true
      Merotele.config.token = phone_token
    else
      Merotele.config.is_bot = false
      Merotele.config.phone = phone_token
    end
  elseif data.token and not Merotele_function.exists('.CallBack-Bot/'..data.session_name) then
    Merotele.config.is_bot = true
    Merotele.config.token = data.token
  end
  if not Merotele_function.exists('.CallBack-Bot') then
    os.execute('sudo mkdir .CallBack-Bot')
  end
  Merotele.config.encryption_key = data.encryption_key or ''
  Merotele.config.parameters = {
    Merotele = 'setTdlibParameters',
    use_message_database = data.use_message_database or true,
    api_id = data.api_id,
    api_hash = data.api_hash,
    use_secret_chats = use_secret_chats or true,
    system_language_code = data.language_code or 'en',
    device_model = 'Merotele',
    system_version = data.system_version or 'linux',
    application_version = '1.0',
    enable_storage_optimizer = data.enable_storage_optimizer or true,
    use_pfs = data.use_pfs or true,
    database_directory = '.CallBack-Bot/'..data.session_name
  }
  return Merotele_function
end
function Merotele.login(state)
  if state.name == 'version' and state.value and state.value.value then
  elseif state.authorization_state and state.authorization_state.Merotele == 'error' and (state.authorization_state.message == 'PHONE_NUMBER_INVALID' or state.authorization_state.message == 'ACCESS_TOKEN_INVALID') then
    if state.authorization_state.message == 'PHONE_NUMBER_INVALID' then
      print(Merotele_function.colors('%{red} Phone Number invalid Error ?!'))
    else
      print(Merotele_function.colors('%{yellow} Token Bot invalid Error ?!'))
    end
    io.write(Merotele_function.colors('\n%{green} Please Use Token or Phone to call : '))
    local phone_token = io.read()
    if phone_token:match('%d+:') then
      function_core.send_tdlib{
        Merotele = 'checkAuthenticationBotToken',
        token = phone_token
      }
    else
      function_core.send_tdlib{
        Merotele = 'setAuthenticationPhoneNumber',
        phone_number = phone_token
      }
    end
  elseif state.authorization_state and state.authorization_state.Merotele == 'error' and state.authorization_state.message == 'PHONE_CODE_INVALID' then
    io.write(Merotele_function.colors('\n%{green}The Code : '))
    local code = io.read()
    function_core.send_tdlib{
      Merotele = 'checkAuthenticationCode',
      code = code
    }
  elseif state.authorization_state and state.authorization_state.Merotele == 'error' and state.authorization_state.message == 'PASSWORD_HASH_INVALID' then
    print(Merotele_function.colors('%{red}two-step is wrong !'))
    io.write(Merotele_function.colors('\n%{green}The Password : '))
    local password = io.read()
    function_core.send_tdlib{
      Merotele = 'checkAuthenticationPassword',
      password = password
    }
  elseif state.Merotele == 'authorizationStateWaitTdlibParameters' or (state.authorization_state and state.authorization_state.Merotele == 'authorizationStateWaitTdlibParameters') then
    function_core.send_tdlib{
      Merotele = 'setTdlibParameters',
      parameters = Merotele.config.parameters
    }
  elseif state.authorization_state and state.authorization_state.Merotele == 'authorizationStateWaitEncryptionKey' then
    function_core.send_tdlib{
      Merotele = 'checkDatabaseEncryptionKey',
      encryption_key = Merotele.config.encryption_key
    }
  elseif state.authorization_state and state.authorization_state.Merotele == 'authorizationStateWaitPhoneNumber' then
    if Merotele.config.is_bot then
      function_core.send_tdlib{
        Merotele = 'checkAuthenticationBotToken',
        token = Merotele.config.token
      }
    else
      function_core.send_tdlib{
        Merotele = 'setAuthenticationPhoneNumber',
        phone_number = Merotele.config.phone
      }
    end
  elseif state.authorization_state and state.authorization_state.Merotele == 'authorizationStateWaitCode' then
      io.write(Merotele_function.colors('\n%{green}The Password : '))
      local code = io.read()
      function_core.send_tdlib{
        Merotele = 'checkAuthenticationCode',
        code = code
      }
  elseif state.authorization_state and state.authorization_state.Merotele == 'authorizationStateWaitPassword' then
      io.write(Merotele_function.colors('\n%{green}Password [ '..state.authorization_state.password_hint..' ] : '))
      local password = io.read()
      function_core.send_tdlib{
        Merotele = 'checkAuthenticationPassword',
        password = password
      }
  elseif state.authorization_state and state.authorization_state.Merotele == 'authorizationStateWaitRegistration' then
    io.write(Merotele_function.colors('\n%{green}The First name : '))
    local first_name = io.read()
    io.write(Merotele_function.colors('\n%{green}The Last name : '))
    local last_name = io.read()
    function_core.send_tdlib{
      Merotele = 'registerUser',
      first_name = first_name,
      last_name = last_name
    }
  elseif state.authorization_state and state.authorization_state.Merotele == 'authorizationStateReady' then
    print(Merotele_function.colors("%{yellow}The files have been connected and played ...\n"))
  elseif state.authorization_state and state.authorization_state.Merotele == 'authorizationStateClosed' then
    print(Merotele_function.colors('%{yellow}>> authorization state closed '))
    Merotele.get_update = false
  elseif state.Merotele == 'error' and state.message then
  elseif not (state.Merotele and Merotele_function.in_array({'updateConnectionState', 'updateSelectedBackground', 'updateConnectionState', 'updateOption',}, state.Merotele)) then
    return true
  end
end
return Merotele
