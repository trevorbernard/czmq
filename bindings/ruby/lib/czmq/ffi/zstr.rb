################################################################################
#  THIS FILE IS 100% GENERATED BY ZPROJECT; DO NOT EDIT EXCEPT EXPERIMENTALLY  #
#  Please refer to the README for information about making permanent changes.  #
################################################################################

module CZMQ
  module FFI

    # sending and receiving strings
    class Zstr
      class DestroyedError < RuntimeError; end

      # Boilerplate for self pointer, initializer, and finalizer
      class << self
        alias :__new :new
      end
      def initialize ptr, finalize=true
        @ptr = ptr
        if @ptr.null?
          @ptr = nil # Remove null pointers so we don't have to test for them.
        elsif finalize
          @finalizer = self.class.create_finalizer_for @ptr
          ObjectSpace.define_finalizer self, @finalizer
        end
      end
      def self.create_finalizer_for ptr
        Proc.new do
          "WARNING: "\
          "Objects of type #{self} cannot be destroyed implicitly. "\
          "Please call the correct destroy method with the relevant arguments."
        end
      end
      def null?
        !@ptr or @ptr.null?
      end
      # Return internal pointer
      def __ptr
        raise DestroyedError unless @ptr
        @ptr
      end
      # So external Libraries can just pass the Object to a FFI function which expects a :pointer
      alias_method :to_ptr, :__ptr
      # Nullify internal pointer and return pointer pointer
      def __ptr_give_ref
        raise DestroyedError unless @ptr
        ptr_ptr = ::FFI::MemoryPointer.new :pointer
        ptr_ptr.write_pointer @ptr
        ObjectSpace.undefine_finalizer self if @finalizer
        @finalizer = nil
        @ptr = nil
        ptr_ptr
      end

      # Receive C string from socket. Caller must free returned string using
      # zstr_free(). Returns NULL if the context is being terminated or the 
      # process was interrupted.                                            
      def self.recv(source)
        result = ::CZMQ::FFI.zstr_recv(source)
        result
      end

      # Receive a series of strings (until NULL) from multipart data.    
      # Each string is allocated and filled with string data; if there   
      # are not enough frames, unallocated strings are set to NULL.      
      # Returns -1 if the message could not be read, else returns the    
      # number of strings filled, zero or more. Free each returned string
      # using zstr_free(). If not enough strings are provided, remaining 
      # multipart frames in the message are dropped.                     
      def self.recvx(source, string_p, *args)
        result = ::CZMQ::FFI.zstr_recvx(source, string_p, *args)
        result
      end

      # Send a C string to a socket, as a frame. The string is sent without 
      # trailing null byte; to read this you can use zstr_recv, or a similar
      # method that adds a null terminator on the received string. String   
      # may be NULL, which is sent as "".                                   
      def self.send(dest, string)
        string = String(string)
        result = ::CZMQ::FFI.zstr_send(dest, string)
        result
      end

      # Send a C string to a socket, as zstr_send(), with a MORE flag, so that
      # you can send further strings in the same multi-part message.          
      def self.sendm(dest, string)
        string = String(string)
        result = ::CZMQ::FFI.zstr_sendm(dest, string)
        result
      end

      # Send a formatted string to a socket. Note that you should NOT use
      # user-supplied strings in the format (they may contain '%' which  
      # will create security holes).                                     
      def self.sendf(dest, format, *args)
        format = String(format)
        result = ::CZMQ::FFI.zstr_sendf(dest, format, *args)
        result
      end

      # Send a formatted string to a socket, as for zstr_sendf(), with a      
      # MORE flag, so that you can send further strings in the same multi-part
      # message.                                                              
      def self.sendfm(dest, format, *args)
        format = String(format)
        result = ::CZMQ::FFI.zstr_sendfm(dest, format, *args)
        result
      end

      # Send a series of strings (until NULL) as multipart data   
      # Returns 0 if the strings could be sent OK, or -1 on error.
      def self.sendx(dest, string, *args)
        string = String(string)
        result = ::CZMQ::FFI.zstr_sendx(dest, string, *args)
        result
      end

      # Free a provided string, and nullify the parent pointer. Safe to call on
      # a null pointer.                                                        
      def self.free(string_p)
        result = ::CZMQ::FFI.zstr_free(string_p)
        result
      end

      # Self test of this class
      def self.test(verbose)
        verbose = !(0==verbose||!verbose) # boolean
        result = ::CZMQ::FFI.zstr_test(verbose)
        result
      end
    end
  end
end

################################################################################
#  THIS FILE IS 100% GENERATED BY ZPROJECT; DO NOT EDIT EXCEPT EXPERIMENTALLY  #
#  Please refer to the README for information about making permanent changes.  #
################################################################################
